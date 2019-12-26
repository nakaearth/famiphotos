# frozen_string_literal: true
class Group < FamiphotoBase
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true, length: { maximum: 80 }
end
