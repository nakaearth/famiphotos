class Group < ActiveRecord::Base
  include IdEncryptable

  has_many :group_members, dependent: :destroy
  has_many :sub_groups

  validates :name, presence: true
end
