class Group < FamiphotoBase

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members, source: :user
  has_many :albums, dependent: :destroy

  accepts_nested_attributes_for :group_members
  accepts_nested_attributes_for :albums

  validates :name, presence: true

  # group作成後group_memberも作成する
  def save_with_group_member(user, role)
    return false unless save

    GroupMember.new(user: user, group: self, role: role).save
  end
end
