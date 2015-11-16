class PhotoGeo < ActiveRecord::Base
  belongs_to :photo

  geocoded_by :address, :latitude, :longitude
  before_validation :geocode

end
