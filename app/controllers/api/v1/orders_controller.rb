class Api::V1::OrdersController < ApiController
  before_action :authenticate_consumer_from_token!
  before_action :authenticate_consumer!
  before_action :validate_address, only: [:create]
  before_action :construct_products_for_order, only: [:create]
  before_action :construct_payment_method_for_order, only: [:create]
  before_action :validate_products, only: [:create]
  before_action :validate_payment_method, only: [:create]

  def index
    if (params[:sn].present?)
      @order = find_order_by_sn(params[:sn])
      return render :show
    end

    @orders = Order.includes(:address).includes(:line_items).includes(:products).where(consumer_id: current_consumer.id, deleted: false).order('created_at DESC')
  end

  def update
    @order = find_order_by_sn(params[:id])
    update_order_state(@order)
    update_order_handle_state(@order)
    render :show
  end

  def update_order_handle_state(order)
    ActiveRecord::Base.transaction do
      order.update_attributes(handle_state: order_update_params[:handle_state]) if order_update_params[:handle_state] == '已收货' && @order.state == '已支付'
    end
  end

  def update_order_state(order)
    ActiveRecord::Base.transaction do
      order.update_attributes(state: order_update_params[:state]) if order_update_params[:state] == '支付中' && @order.state == '未支付'
    end
  end

  def destroy
    @order = find_order_by_sn(params[:id])

    if (@order.state == '未支付')
      @order.update_attributes(deleted: true)
      @message = "成功删除订单#{@order.sn}"

      @order.line_items.each do |line_item|
        line_item.product.add_stock_number(line_item.quantity)
      end
    else
      @message = '该订单已支付，无法删除'
    end
    render :message
  end

  def show
    @order = Order.find(params[:id].to_i)
    raise UnauthorizedException unless @order.try(:consumer_id) == current_consumer.id
  end

  def create
    @orders = []

    split_products_by_customer.each do |customer_id, products|

      if (@payment_method && @payment_method.try(:name) != '货到付款')
        only_cash_products = products.select { |product| product.cash_on_delivery == '仅支持货到付款' }
        products = products - only_cash_products
        payment_method = PaymentMethod.find_by_name('货到付款')
        create_orders_for_products(customer_id, only_cash_products, payment_method) if only_cash_products.present?
      end

      create_orders_for_products(customer_id, products, @payment_method)
    end

    render :index, status: :created
  end

  def create_orders_for_products(customer_id, products, payment_method)
    ActiveRecord::Base.transaction do
      order_total_price = 0
      order_line_items = products.map do |product|
        quantity = product.quantity_for_order
        product.reduce_stock_number(quantity)
        unit_price = product.sku_id_for_order ? (sku = Sku.find(product.sku_id_for_order.to_i)).price : product.price
        order_total_price += unit_price.to_f * quantity
        LineItem.create(product_id: product.id, quantity: quantity, unit_price: unit_price.to_f, sku_id: sku.try(:id))
      end

      order = create_order(order_total_price, order_line_items, customer_id, payment_method)
      calculate_shipment_fee(order)
      @orders << order
    end
  end

  private
  def order_params
    params.require(:order).permit(:address_id, :comment, :invoice_title, :payment_method_id, products: [:id, :quantity, :sku_id])
  end

  def order_update_params
    params.require(:order).permit(:state, :handle_state)
  end

  def find_order_by_sn(sn)
    raise ActiveRecord::RecordNotFound, "Can not find order" unless sn
    @order = Order.find_by_sn(sn)
    raise ActiveRecord::RecordNotFound, "Can not find order with sn #{sn}" unless @order
    raise ActiveRecord::RecordNotFound, "Order sn #{sn} has been deleted" if @order.deleted
    raise UnauthorizedException unless @order.try(:consumer_id) == current_consumer.id
    @order
  end

  def validate_address
    address = Address.find(order_params[:address_id])
    raise ActiveRecord::RecordNotFound, 'Address has been deleted' if address.deleted
    raise UnauthorizedException unless address.try(:consumer_id) == current_consumer.id
  end

  def create_order(total_price, line_items, customer_id, payment_method)
    order = Order.create(consumer_id: current_consumer.id,
                         address_id: order_params[:address_id],
                         comment: order_params[:comment],
                         invoice_title: order_params[:invoice_title],
                         total_price: total_price,
                         state: '未支付',
                         payment_method_id: payment_method.try(:id),
                         payment_method_name: payment_method.try(:name),
                         sn: "#{DateTime.now.to_i}#{rand(9999)}",
                         customer_id: customer_id)
    order.line_items << line_items
    order
  end

  def calculate_shipment_fee(order)
    shipment_fee = FreeShipmentCoupon.last && (order.total_price > FreeShipmentCoupon.last.try(:min_price)) ? 0 : ShipmentFeeService.calculate(order)
    order.update_attributes(ship_fee: shipment_fee)
  end

  def split_products_by_customer
    @products_for_order.group_by(&:customer_id)
  end


  def construct_products_for_order
    @products_for_order = order_params[:products].map do |product_param|
      product = Product.find(product_param[:id])
      product.quantity_for_order = product_param[:quantity]
      product.sku_id_for_order = product_param[:sku_id]
      product
    end
  end

  def construct_payment_method_for_order
    @payment_method = PaymentMethod.find(order_params[:payment_method_id]) if order_params[:payment_method_id]
  end

  def validate_products
    @products_for_order.each do |product|
      if product.sku_id_for_order
        sku = Sku.find(product.sku_id_for_order)
        raise UnprocessableEntityException, "产品#{product.id}的Sku #{product.sku_id_for_order} 不存在" unless sku.product_id == product.id
      end
      raise UnprocessableEntityException, "产品#{product.id}库存不足" if product.stock_number && product.stock_number < product.quantity_for_order
    end
  end

  def validate_payment_method
    payment_conflict = @payment_method && @products_for_order.select { |product| product.cash_on_delivery == '不支持货到付款' }.present? && @payment_method.try(:name) == '货到付款'
    raise UnprocessableEntityException, "商品不支持货到付款" if payment_conflict
  end

end
