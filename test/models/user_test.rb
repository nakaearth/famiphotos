require "test_helper"

class UserTest < ActiveSupport::TestCase
  # let(:user) { create(:user) }

  def test_validation
    user = User.new(name: 'test', uid: '12345abcd', email: 'hoge@gmail.com', provider: 'twitter')
    value(user).must_be :valid?
  end

  def test_validation2
    user = User.new(name: nil, uid: '12345abcd', email: 'hoge@gmail.com', provider: 'twitter')
    assert_equal user.valid?, false
  end
end
