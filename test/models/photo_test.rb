require "test_helper"

class PhotoTest < ActiveSupport::TestCase

  def test_validation

    user = create(:user)
    user = Photo.new(description: 'ほげです', user: user)
    value(user).must_be :valid?
  end
end
