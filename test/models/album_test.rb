require "test_helper"

class AlbumTest < ActiveSupport::TestCase
  def album
    @album ||= Album.new
  end

  def test_title_is_nil
    group = create(:group)
    album = Album.new(group: group, title: nil)

    value(album).must_be :invalid?
  end
  
  def test_title_length_is_over_80
    group = create(:group)
    album = Album.new(group: group, title: ('abcdefghij' * 8).concat('1'))

    value(album).must_be :invalid?
  end
  
  def test_valid
    group = create(:group)
    album = Album.new(group: group, title: 'abcdefghij' * 8)

    value(album).must_be :valid?

    album.save!
    saved_album = Album.find_by(group: group)
    assert_equal album.id, saved_album.id
  end
end
