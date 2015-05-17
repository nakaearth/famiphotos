class Group < ActiveRecord::Base
  include IdEncryptable

  validate :name, presence: true
end
