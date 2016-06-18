json.product do
  json.id @product.id
  json.colorId 2
  json.name @product.name
  json.images @product.product_images.map(&:url)
  json.description @product.description
  json.price @product.price
  json.unit @product.unit
  json.stock_number @product.stock_number
  json.sold_number @product.sold_number
  json.cash_on_delivery @product.cash_on_delivery
  json.free_ship @product.free_ship
  json.sold_amount 121
  json.comments ["好产品", "经久耐用"]
  json.service_description "由\"#{@product.customer ? @product.customer.name : '开县春秋农业开发有限公司'}\"直接销售和发货，并提供售后服务"
  json.score 4.74
  json.attitude 4.78
  json.logistics 4.75
  json.customer do
    if @product.customer
      json.id @product.customer.id
      json.name @product.customer.name
    else
      json.name "开县春秋农业开发有限公司"
      json.telephone "023-12343223"
    end
  end
  json.product_details @product.product_details.map(&:url)
  json.services @product.services.map(&:url)
  json.skus @product.skus
end