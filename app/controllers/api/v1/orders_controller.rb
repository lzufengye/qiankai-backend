class Api::V1::OrdersController < ApiController
  before_action :authenticate_consumer_from_token!
  before_action :authenticate_consumer!

  def index
    if(params[:sn].present?)
      @order = Order.find_by_sn(params[:sn])
      raise ActiveRecord::RecordNotFound, "Can not find order with sn #{params[:sn]}" unless @order
      raise UnauthorizedException unless @order.try(:consumer_id) == current_consumer.id
      return render :show
    end

    @orders = Order.includes(:line_items).includes(:products).where(consumer_id: current_consumer.id).order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id].to_i)
  end

  def create
    total_price = 0

    line_items = order_params[:products].map do |item|
      quantity = item[:quantity]
      product = Product.find(item[:id].to_i)
      total_price += product.price.to_f * quantity
      LineItem.create(product_id: product.id, quantity: quantity, unit_price: product.price.to_f)
    end

    @order = Order.create(consumer_id: current_consumer.id,
                         address_id: params[:order][:address_id],
                         total_price: total_price,
                         state: '未支付',
                         ship_fee: order_params[:ship_fee],
                         sn: "#{DateTime.now.to_i}#{rand(9999)}")
    @order.line_items << line_items

    render :show
  end

  private
  def order_params
    params.require(:order).permit(:address_id, :ship_fee, products: [:id, :quantity])
  end

end
