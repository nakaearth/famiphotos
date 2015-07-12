class Group < ActiveRecord::Base
  include IdEncryptable

  validates :name, presence: true
end
