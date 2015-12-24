require "test_helper"

class Photos::UploadServiceTest < ActiveSupport::TestCase
  setup do
    @photo_params = {
      description: 'これはテスト', 
      image: "#{Rails.root}/test/fixtures/test.jpg", 
      photo_geo_attributes: [
        address: '東京都港区'
      ]
    }
  end

  def test_file_upload
    assert_nothing_raised { Photos::UploadService.execute(create(:user), @photo_params) }
  end
end
