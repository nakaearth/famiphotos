require "test_helper"

class Photos::UploadServiceTest < ActiveSupport::TestCase
  setup do
    @photo_params = {
      description: 'これはテスト',
      image: File.open("#{Rails.root}/test/fixtures/test.jpg")
    }

    group = create(:group)

    @user = create(:user, group: group)
  end

  def test_file_upload
    assert_nothing_raised { Photos::UploadService.execute(@user, @photo_params) }
    assert_operator @user.photos.count, :>, 0
  end

  def test_file_upload_with_address
    @photo_params.merge!({ photo_geo_attributes: { address: '東京都渋谷区' } })

    assert_nothing_raised { Photos::UploadService.execute(@user, @photo_params) }
    assert_operator @user.photos.count, :>, 0
    assert_not_nil @user.photos.last.photo_geo
  end

  def test_file_upload_error
    @photo_upload_error_params = {
      description: 'これはテスト',
      image: File.open("#{Rails.root}/test/fixtures/test.txt")
    }

    assert_raise(ActiveRecord::RecordInvalid) { Photos::UploadService.execute(@user, @photo_upload_error_params) }
  end
  
  def test_file_upload_input_error
    @photo_upload_error_params = {
      description: 'これテスト' * 28 + 'だ',
      image: File.open("#{Rails.root}/test/fixtures/test.txt")
    }

    assert_raise(ActiveRecord::RecordInvalid) { Photos::UploadService.execute(@user, @photo_upload_error_params) }
  end
end
