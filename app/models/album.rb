# frozen_string_literal: true
class Album < FamiphotoBase
  include Searchable
  ####################################################################
  ################# Association ######################################
  ####################################################################
  # has_many :photos, inverse_of: :album
  has_many :photos
  has_one  :shared_album
  belongs_to :user

  ####################################################################
  ####################### Validation #################################
  ####################################################################
  validates :title, presence: true, length: { maximum: 80 }

  ####################################################################
  ##################### コールバック群 ###############################
  ####################################################################

  ####################################################################
  ##################### クラスメソッド ###############################
  ####################################################################
  class << self
  end

  ####################################################################
  ##################### インスタンスメソッド #########################
  ####################################################################
  # [memo] もしかしたら、これはdecoratorにおくべきかな？
  def top_image_url
    return 'no_photo.jpeg' if photos.blank?

    photos.first.thumb_url
  end
end
