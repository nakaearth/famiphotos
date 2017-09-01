# frozen_string_literal: true
json.array @informations do |information|
  json.id information.id
  json.title information.title
  json.message information.message
end
