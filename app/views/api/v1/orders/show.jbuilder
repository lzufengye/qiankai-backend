json.order do
  json.sn @order.sn
  json.customer_id @order.customer_id
  json.state @order.state
  json.handle_state @order.handle_state
  json.total_price @order.total_price
  json.ship_fee @order.ship_fee
  json.address @order.address
  json.comment @order.comment
  json.invoice_title @order.invoice_title
  json.payment_method_id @order.payment_method_id
  json.payment_method_name @order.payment_method_name
  json.logistical do
    json.name @order.logistical
    json.number @order.logistical_number
  end
  json.created_at @order.created_at.strftime('%Y-%m-%d')

  json.line_items @order.line_items do |line_item|
    json.quantity line_item.quantity
    json.product do
      json.id line_item.try(:product).try(:id)
      json.name line_item.try(:product).try(:name)
      json.image line_item.try(:product).try(:product_images).try(:size) && line_item.try(:product).try(:product_images).try(:size) > 0 ? line_item.product.product_images[0].url : ''
      json.sku line_item.sku
      json.price line_item.unit_price
    end
  end
end