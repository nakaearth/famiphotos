class Photo < ActiveRecord::Base
  include IdEncryptable
  include Searchable

  use_switch_point :famiphoto

  mount_uploader :image,  ImageUploader

  ####################################################################
  ################# Association ######################################
  ####################################################################
  belongs_to :user
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
end
