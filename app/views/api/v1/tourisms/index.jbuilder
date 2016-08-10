json._links do
  json.self do
    json.href '/api/v1/tourisms'
  end
end

json.tourisms @tourisms do |tourism|
  json.id tourism.id
  json.title tourism.title
  json.phone tourism.phone
  json.image tourism.attachments.size > 0 ? tourism.attachments[0].url : ''
  json.description tourism.description
  json.content tourism.content
end