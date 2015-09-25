class SubGroup < ActiveRecord::Base
  include IdEncryptable

  belongs_to :group

  validates :name, presence: true
end
