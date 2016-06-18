json._links do
  json.self do
    json.href '/api/v1/products'
  end
end

json.products @products do |product|
  json.id product.id
  json.name product.name
  json.image product.product_images.size > 0 ? product.product_images[0].url : ''
  json.description product.description
  json.price product.price
  json.unit product.unit
  json.free_ship product.free_ship
  json.stock_number product.stock_number
  json.sold_number product.sold_number
  json.display_order product.display_order
  json.cash_on_delivery product.cash_on_delivery
end