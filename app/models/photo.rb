class Photo < ActiveRecord::Base
  include IdEncryptable
  include Searchable

  use_switch_point :famiphoto

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

  # productionで利用する場合は、ここの設定を環境変数ごとに分けるようにしたほうがいいだろう
  has_attached_file :photo,
                    styles: { medium: "300x300>", thumb: "100x100>", original: "500x500" },
                    url: "/assets/arts/:id/:style/:basename.:extension",
                    path: "#{Rails.root}/public/assets/:img_dir_num/:id/:style/:basename.:extension"

  validates_attachment :photo,  content_type: { content_type: ["image/jpg",  "image/jpeg",  "image/png",  "image/gif"] }

  ####################################################################
  ##################### コールバック群 ###############################
  ####################################################################

  Paperclip.interpolates :img_dir_num do |attachment, _style|
    (attachment.instance.user_id).to_s
  end
end
