json.virtual_tourisms @virtual_tourisms do |virtual_tourisms|
  json.id virtual_tourisms.id
  json.title virtual_tourisms.title
  json.description virtual_tourisms.description
  json.video virtual_tourisms.video.try(:url)
  json.video_thumb virtual_tourisms.video_thumb
end