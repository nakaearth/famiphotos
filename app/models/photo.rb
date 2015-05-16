class Photo < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  validates :description, length: { maximum: 140 }
end
