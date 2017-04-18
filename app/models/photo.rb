# frozen_string_literal: true
class Photo < FamiphotosPlatform::FamiphotoBase
  include Searchable

  use_switch_point :famiphoto

  mount_uploader :image, ImageUploader

  alias_attribute :start_time, :created_at

  ####################################################################
  ################# Association ######################################
  ####################################################################
  belongs_to :user
  belongs_to :album, optional: true, inverse_of: :photos
  has_one :photo_geo, dependent: :destroy
  has_many :tags, inverse_of: :photos

  ####################################################################
  ####################### nested_attributes_for ######################
  ####################################################################
  accepts_nested_attributes_for :photo_geo
  accepts_nested_attributes_for :tags

  ####################################################################
  ####################### Validation #################################
  ####################################################################
  validates :description, length: { maximum: 140 }

  ####################################################################
  ##################### コールバック群 ###############################
  ####################################################################

  ####################################################################
  ##################### インスタンスメソッド #########################
  ####################################################################
  def thumb_url
    image.thumb.url
  end
end
