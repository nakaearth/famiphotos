class User < ActiveRecord::Base
  # has_many :group_members, dependent: :destroy
  # has_many :my_groups, through: :group_members, source: :group
  # has_many :my_job_cards, class_name: JobCard, inverse_of: :user
  # has_one :friend, dependent: :destroy
  # has_many :friend_request_registrations

  validates :name, presence: true, length: { maximum: 60 }
  validates :uid, presence: true
  validates :email, length: { maximum: 60 }
  validates :provider, presence: true, length: { maximum: 10 }

  after_create :create_group_members

  def self.create_account(auth)
    # Users::Registration.new.regist auth
  end

  protected

  def create_group_members
    #group = Group.find_or_create_by(name: name + ' group')
    #GroupMember.find_or_create_by(user: self, group: group)
  end
end
