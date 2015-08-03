class Photo < ActiveRecord::Base
  include IdEncryptable
  include Searchable

  # after_save TODO: save後にelasticsearchにデータいれるようにする

  has_attached_file :photo,  styles: { medium: "300x300>",  thumb: "100x100>" }

  belongs_to :user

  validates :description, length: { maximum: 140 }
  validates_attachment :photo,  content_type: { content_type: ["image/jpg",  "image/jpeg",  "image/png",  "image/gif"] }
end
