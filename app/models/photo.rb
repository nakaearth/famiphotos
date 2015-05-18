class Photo < ActiveRecord::Base
  include IdEncryptable

  mount_uploader :photo, PhotoUploader

  belongs_to :user, dependent: :destroy

  validates :description, length: { maximum: 140 }
end
