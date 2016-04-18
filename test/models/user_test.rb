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
end
