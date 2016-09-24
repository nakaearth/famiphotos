require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  before do
    @user = create(:user)
  end

  def test_validation
    photo = Photo.new(description: 'ほげです' * 28, user: @user)
    value(photo).must_be :valid?
  end

  def test_validation
    photo = Photo.new(description: 'ほげですよ' * 28 + 'ね', user: @user)
    value(photo).must_be :invalid?
  end


  def test_relation_tags
    photo = Photo.create(description: 'ほげです', user: @user)
    tags  = photo.tags.build(name: 'ruby', group: @user.group)

    assert_equal true, tags.save
  end
end
