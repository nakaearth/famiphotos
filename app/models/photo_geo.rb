# frozen_string_literal: true
class PhotoGeo < FamiphotoBase
  belongs_to :photo, optional: true

  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address_changed? }
end
