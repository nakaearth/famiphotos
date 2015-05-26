Jbuilder.encode do |json|

  json.photo @photos do |photo|
    json.title photo.title
    json.thumnail photo.photo.url(:thumb)
    json.created_at photo.created_at
  end
end
