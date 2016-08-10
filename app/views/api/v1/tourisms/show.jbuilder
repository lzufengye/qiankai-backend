json.tourism do
  json.id @tourism.id
  json.title @tourism.title
  json.phone @tourism.phone
  json.images @tourism.attachments.map(&:url)
  json.description @tourism.description
  json.content @tourism.content
end