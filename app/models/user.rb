# frozen_string_literal: true
class User < FamiphotosPlatform::FamiphotoBase
  include Encryptedable

  attr_encrypted :uid

  use_switch_point :famiphoto unless Rails.env.test?

  has_many :photos, inverse_of: :user
  has_many :albums

  validates :name, presence: true, length: { maximum: 60 }
  validates :uid, presence: true
  validates :email, length: { maximum: 60 }
  validates :provider, presence: true, length: { maximum: 30 }

  after_create :create_default_album

  class << self
    def create_account(auth)
      Users::Registration.new.regist auth
    end
  end

  protected

  def create_default_album
    Album.find_or_create_by(user_id: id, title: "#{name}のアルバム")
  end
end
