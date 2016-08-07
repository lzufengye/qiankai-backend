json.customers @customers do |customer|
  json.id customer.id
  json.name customer.name
  json.phone customer.phone
  json.description customer.description
  json.image customer.attachments.size > 0 ? customer.attachments[0].url : ''
end