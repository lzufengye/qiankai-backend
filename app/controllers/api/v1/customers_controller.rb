class Api::V1::CustomersController < ApiController

  def index
    @customers = Customer.includes(:attachments).all
  end

  def show
    @customer = Customer.find(params[:id].to_i)
    @products = Product.includes(:product_images).where(customer_id: params[:id].to_i)
  end

end
