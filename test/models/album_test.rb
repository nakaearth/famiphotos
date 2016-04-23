require "test_helper"

class AlbumTest < ActiveSupport::TestCase
  def album
    @album ||= Album.new
  end

  def test_valid
    assert album.valid?
  end
end
