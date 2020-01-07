# frozen_string_literal: true
class UserGroup < FamiphotoBase
  belongs_to :owner, class_name: 'User'
  belongs_to :user
  belongs_to :group

  validates :name, presence: true, length: { maximum: 80 }
end
