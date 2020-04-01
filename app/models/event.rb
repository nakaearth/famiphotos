# frozen_string_literal: true
class Event < FamiphotoBase
  belongs_to :user
  belongs_to :group, optional: true, inverse_of: :events

  validates :description, length: { maximum: 140 }
end
