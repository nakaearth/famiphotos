
# frozen_string_literal: true
json.array! @shared_photos.each do |photo|
  json.id photo.id
  json.title photo.title
  json.thumb_url photo.thumb_url
  json.original_url photo.original_url
  json.created_at photo.created_at
  json.updated_at photo.updated_at
end
