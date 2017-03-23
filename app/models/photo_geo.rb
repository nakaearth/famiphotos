class PhotoGeo < FamiphotoBase
  belongs_to :photo

  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address_changed? }
end
