class Api::V1::ShoppingCartsController < ApiController
  before_action :authenticate_consumer_from_token!
  before_action :authenticate_consumer!

  def show
    @cart = ShoppingCart.where(consumer_id: current_consumer.id)
  end

  def update
    @cart = []
    ShoppingCart.where(consumer_id: current_consumer.id).destroy_all
    shopping_cart_params[:products].each do |item|
      @cart << ShoppingCart.create(consumer_id: current_consumer.id, product_id: item[:id], sku_id: item[:sku_id], quantity: item[:quantity])
    end
    @cart
    render :show
  end

  def destroy
    ShoppingCart.where(consumer_id: current_consumer.id).destroy_all
    @cart = []
    render :show
  end

  private
  def shopping_cart_params
    params.require(:cart).permit(products: [:id, :quantity, :sku_id])
  end

end
