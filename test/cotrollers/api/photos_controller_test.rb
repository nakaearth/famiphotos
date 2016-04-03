require 'test_helper'

module Api
  class PhotosControllerTest < ActionController::TestCase
    include DecryptedUid

    def setup
      @user = create(:user, uid: Base64.strict_encode64('11223344'))
      create_list(:photo, 5, user: @user, image: 'test/fixtures/test.png')
    end

    test 'index controller' do
      get :index, uid: Base64.strict_encode64('11223344')

      assert_not_nil assigns[:photos]
      assert_equal @user.photos.size,  assigns[:photos].size
    end

    test 'create controller' do
      # テスト追加
    end
  end
end
