class Api::V1::ProductsController < ApiController

  def index
    products = Tag.find_by_display(params['tag']) ? Tag.find_by_display(params['tag']).products.includes(:customer).includes(:product_images).where(on_sale: true, archive: false) : []
    products = products.to_a.sort_by{|product| product.display_order}.reverse
    @products = paginate products, per_page: params[:limit] || 10
  end

  def show
    @product = Product.find(params['id'].to_i)
  end

  def search
    products = Product.where("name like ?", "%#{params[:key_word]}%").where(on_sale: true, archive: false)
    @products = paginate products, per_page: params[:limit] || 10
    render :index
  end

end
