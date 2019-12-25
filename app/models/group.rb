# frozen_string_literal: true
class Group < FamiphotoBase
  belongs_to :user

  validates :name, presence: true, length: { maximum: 80 }
end
