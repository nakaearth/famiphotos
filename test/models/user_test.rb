require "test_helper"

class UserTest < ActiveSupport::TestCase

  def test_validation_success_case
    user = User.new(name: 'test', uid: '12345abcd', email: 'hoge@gmail.com', provider: 'twitter')
    value(user).must_be :valid?
  end

  def test_name_validation_error_case
    user = User.new(name: nil, uid: '12345abcd', email: 'hoge@gmail.com', provider: 'twitter')
    assert_equal user.valid?, false
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end

  def test_uid_validation_error_case
    user = User.new(name: 'hoge', uid: nil, email: 'hoge@gmail.com', provider: 'twitter')
    assert_equal user.valid?, false
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end

  def test_email_validation_error_case
    user = User.new(name: 'hoge', uid: '12345abcd', email: 'test12345' * 6 + 'hoge.jp', provider: 'twitter')
    assert_equal user.valid?, false
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end

  def test_provider_validation_error_case
    user = User.new(name: 'hoge', uid: '12345abcd', email: 'hoge@gmail.com', provider: nil)
    assert_equal user.valid?, false
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end

  def test_albums_without_this_group
    user = create(:user)

    current_group = create(:group)
    other_group   = create(:group, name: 'テストグループ')
    create(:group_member, group: current_group, user: user)
    create(:group_member, group: other_group, user: user)
    
    create_list(:album, 2, group: current_group)
    create_list(:album, 3, group: other_group)

    assert_equal 3, user.albums_without_this_group(current_group).size
    assert_equal 2, user.albums_without_this_group(other_group).size
  end
end
