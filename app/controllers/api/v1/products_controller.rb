class Api::V1::ProductsController < ApiController

  def index
    products = Tag.find_by_display(params['tag']) ? Tag.find_by_display(params['tag']).products.where(on_sale: true) : []
    products = products.to_a.sort_by{|product| product.display_order}.reverse
    @products = paginate products, per_page: params[:limit] || 10
  end

  def show
    @product = Product.find(params['id'].to_i)
    raise ActiveRecord::RecordNotFound, '此商品已下架' unless @product.on_sale
  end

  def search
    products = Product.where("name like ?", "%#{params[:key_word]}%")
    @products = paginate products, per_page: params[:limit] || 10
    render :index
  end

end
