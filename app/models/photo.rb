class Photo < ActiveRecord::Base
  include IdEncryptable
  include Searchable

  use_switch_point :famiphoto

  belongs_to :user

  validates :description, length: { maximum: 140 }

  has_attached_file :photo,
                    styles: { medium: "300x300>", thumb: "100x100>", original: "500x500" },
                    deault_url: "/images/:style/missing.png",
                    path: "photos/:img_dir_num/:style/:filename"

  validates_attachment :photo,  content_type: { content_type: ["image/jpg",  "image/jpeg",  "image/png",  "image/gif"] }

  Paperclip.interpolates :img_dir_num do |attachment, _style|
    (attachment.instance.user_id).to_s
  end
end
