json.array! @photos.each do |photo|
  json.title photo.title
  json.photo photo.image.url
  json.created_at photo.created_at
  json.updated_at photo.updated_at
end
