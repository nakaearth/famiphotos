class Photo < ActiveRecord::Base
  include IdEncryptable

  belongs_to :user, dependent: :destroy

  validates :description, length: { maximum: 140 }
end
