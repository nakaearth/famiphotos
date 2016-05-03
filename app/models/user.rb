class User < FamiphotoBase
  include Encryptedable

  attr_encrypted :uid

  use_switch_point :famiphoto unless Rails.env.test?

  has_many :group_members, dependent: :destroy
  has_many :my_groups, through: :group_members, source: :group
  has_many :photos, inverse_of: :user

  validates :name, presence: true, length: { maximum: 60 }
  validates :uid, presence: true
  validates :email, length: { maximum: 60 }
  validates :provider, presence: true, length: { maximum: 30 }

  after_create :create_group_members

  ####### クラスメソッド ########

  class << self
    def create_account(auth)
      Users::Registration.new.regist auth
    end
  end

  ##### インスタンスメソッド ######
  # 引数で渡されたグループ以外のアルバムを返す
  def albums_without_this_group(group)
    other_groups = my_groups.where.not(id: group.id)
    Album.where(group: other_groups)
  end

  protected

  def create_group_members
    group = Group.find_or_create_by(name: name || "デフォルト#{name}グループ")
    GroupMember.find_or_create_by(user: self, group: group, role: 'owner')
  end
end
