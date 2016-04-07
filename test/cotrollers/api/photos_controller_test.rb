require 'test_helper'
require 'json'

module Api
  class PhotosControllerTest < ActionController::TestCase
    include EncryptionConcern

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
      photo_params = {
        photo: {
          description: 'これはテスト',
          image: File.open("#{Rails.root}/test/fixtures/test.jpg"),
          photo_geo_attributes: {
            address: '神奈川県横浜市'
          } 
        }, 
        uid: Base64.strict_encode64('11223344')
      }


      post :create, photo_params

      assert_equal 200, response.status

      api_photo_json = JSON.parse(response.body)
      assert_equal 'ok', api_photo_json[:status]
    end

    test'show controller' do
    end
  end
end
