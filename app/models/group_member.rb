class GroupMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  scope :not_group_member, ->(user_ids) { where.not('user: ?', user_ids) }
end
