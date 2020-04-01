# frozen_string_literal: true
class Group < FamiphotoBase
  include GroupSearchable

  belongs_to :owner, class_name: 'User'
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :events

  validates :name, presence: true, length: { maximum: 80 }
end
