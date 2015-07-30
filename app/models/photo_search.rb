class PhotoSearch < ActiveRecord::Base
  include Elasticsearch::Model
  index_name 'famiphoto_photo'
end
