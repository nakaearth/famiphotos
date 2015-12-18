class PhotoGeo < ActiveRecord::Base
  belongs_to :photo

  geocoded_by :address
  after_validation :geocode, if: lambda { |obj| obj.address_changed? }
end
