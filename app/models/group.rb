class Group < ActiveRecord::Base
  include IdEncryptable

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members, source: :user

  validates :name, presence: true
end
