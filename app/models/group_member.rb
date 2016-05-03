class GroupMember < FamiphotoBase
  extend Enumerize

  belongs_to :user
  belongs_to :group

  scope :not_group_member, ->(user_ids) { where.not('user: ?', user_ids) }
  scope :role_owner, -> { where(role: 'owner') }

  enumerize :role, in: [:owner, :member]
end
