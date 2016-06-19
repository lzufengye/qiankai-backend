class Api::V1::OrdersController < ApiController
  before_action :authenticate_consumer_from_token!
  before_action :authenticate_consumer!
  before_action :validate_address, only: [:create]
  before_action :validate_products, only: [:create]

  def index
    if(params[:sn].present?)
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
    order.update_attributes(handle_state: order_update_params[:handle_state]) if order_update_params[:handle_state] == '已收货' && @order.state == '已支付'
  end

  def update_order_state(order)
    order.update_attributes(state: order_update_params[:state]) if order_update_params[:state] == '支付中' && @order.state == '未支付'
  end

  def destroy
    @order = find_order_by_sn(params[:id])

    if(@order.state == '未支付')
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
    total_price = 0

    line_items = order_params[:products].map do |item|
      quantity = item[:quantity]
      product = Product.find(item[:id].to_i)
      product.reduce_stock_number(quantity)

      unit_price = item[:sku_id] ? (sku = Sku.find(item[:sku_id].to_i)).price : product.price

      total_price += unit_price.to_f * quantity
      LineItem.create(product_id: product.id, quantity: quantity, unit_price: unit_price.to_f, sku_id: sku.try(:id))
    end

    payment_method = PaymentMethod.find(order_params[:payment_method_id]) if order_params[:payment_method_id]

    @order = create_order(total_price, payment_method, line_items)
    calculate_shipment_fee(@order)

    render :show, status: :created
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

  def validate_products
    order_params[:products].each do |item|
      product = Product.find(item[:id])
      if item[:sku_id]
        sku = Sku.find(item[:sku_id])
        raise UnprocessableEntityException, "产品#{item[:id]}的Sku #{item[:sku_id]} 不存在" unless sku.product_id == product.id
      end
      raise UnprocessableEntityException, "产品#{item[:id]}库存不足" if product.stock_number && product.stock_number < item[:quantity]
    end
  end

  def create_order(total_price, payment_method, line_items)
    order = Order.create(consumer_id: current_consumer.id,
                 address_id: order_params[:address_id],
                 comment: order_params[:comment],
                 invoice_title: order_params[:invoice_title],
                 total_price: total_price,
                 state: '未支付',
                 payment_method_id: payment_method.try(:id),
                 payment_method_name: payment_method.try(:name),
                 sn: "#{DateTime.now.to_i}#{rand(9999)}")
    order.line_items << line_items
    order
  end

  def calculate_shipment_fee(order)
    shipment_fee = FreeShipmentCoupon.last && (order.total_price > FreeShipmentCoupon.last.try(:min_price)) ? 0 : ShipmentFeeService.calculate(order)
    order.update_attributes(ship_fee: shipment_fee)
  end

end
