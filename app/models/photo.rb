class Photo < FamiphotosPlatform::FamiphotoBase
  include Searchable

  use_switch_point :famiphoto 

  mount_uploader :image,  ImageUploader

  ####################################################################
  ################# Association ######################################
  ####################################################################
  belongs_to :user
  belongs_to :album
  has_one :photo_geo

  ####################################################################
  ####################### nested_attributes_for ######################
  ####################################################################
  accepts_nested_attributes_for :photo_geo

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

  def start_time
    created_at
  end
end
