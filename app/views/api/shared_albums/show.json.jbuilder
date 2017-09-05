
json.array! @shared_photos.each do |photo|
  json.title photo.title
  json.thumb_url photo.thumb_url
  json.created_at photo.created_at
  json.updated_at photo.updated_at
end
