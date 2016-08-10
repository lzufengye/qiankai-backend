json._links do
  json.self do
    json.href '/api/v1/hotels'
  end
end

json.hotels @hotels do |hotel|
  json.id hotel.id
  json.name hotel.name
  json.phone hotel.phone
  json.description hotel.description
end