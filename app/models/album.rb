# frozen_string_literal: true
class Album < FamiphotoBase
  include AlbumSearchable

  has_many :photos
  has_many :tags, inverse_of: :album
  has_one  :shared_album
  belongs_to :user

  validates :title, presence: true, length: { maximum: 80 }

  class << self
  end

  # [memo] もしかしたら、これはdecoratorにおくべきかな？
  def top_image_url
    return 'no_photo.jpeg' if photos.blank?

    photos.first.thumb_url
  end
end
