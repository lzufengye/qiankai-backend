json.total_pages @products.total_pages

json._links do
  json.self do
    json.href "/api/v1/products?page=#{@products.current_page}"
  end

  json.first do
    json.href "/api/v1/products?page=1"
  end

  json.prev do
    unless @products.first_page?
      json.href "/api/v1/products?page=#{@products.prev_page}"
    end
  end

  json.next do
    unless @products.last_page?
      json.href "/api/v1/products?page=#{@products.next_page}"
    end
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
  json.customer do
    if product.customer
      json.id product.customer.id
      json.name product.customer.name
      json.phone product.customer.phone
    else
      json.name "开县春秋农业开发有限公司"
    end
  end
end