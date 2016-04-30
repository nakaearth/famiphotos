class Group < FamiphotoBase

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members, source: :user
  has_many :albums, dependent: :destroy

  accepts_nested_attributes_for :albums

  validates :name, presence: true
end
