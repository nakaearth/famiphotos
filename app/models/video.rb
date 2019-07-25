# frozen_string_literal: true
class Video < FamiphotoBase
  use_switch_point :famiphoto

  alias_attribute :start_time, :created_at

  belongs_to :user
  belongs_to :album, optional: true, inverse_of: :photos
  has_many :tags, inverse_of: :photo

  validates :title, length: { maximum: 80 }
end
