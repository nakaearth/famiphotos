require 'test_helper'
require 'json'

module Api
  class PhotosControllerTest < ActionController::TestCase
    include EncryptionConcern

    def setup
      @user = create(:user, uid: '11223344aa')
      create_list(:photo, 5, user: @user, image: 'test/fixtures/test.png', description: 'テストです')
    end

    test 'index controller' do
      get :index, uid: encrypted('11223344aa')

      assert_not_nil assigns[:photos]
      assert_equal @user.photos.size,  assigns[:photos].size
    end

    test 'index controller(no photos)' do
      create(:user, uid: '11223344bb')

      get :index, uid: encrypted('11223344bb')

      assert_not_nil assigns[:photos]
      assert_equal 0,  assigns[:photos].size
    end

    test 'index controller(not exist user)' do
      get :index, uid: encrypted('11223344bb')

      assert_equal 404, response.status
    end

    test 'create controller' do
      photo_params = {
        photo: {
          description: 'これはテスト',
          image: File.open("#{Rails.root}/test/fixtures/test.jpg"),
          photo_geo_attributes: {
            address: '神奈川県横浜市'
          }
        },
        uid: encrypted('11223344aa')
      }

      post :create, photo_params

      assert_equal 200, response.status

      api_photo_json = (JSON.parse(response.body)).with_indifferent_access
      assert_equal 'ok', api_photo_json[:status]
    end

    test 'show controller' do
      photo_params = {
        id: @user.photos[0].id,
        uid: encrypted('11223344aa')
      }

      get :show, photo_params

      assert_equal 200, response.status
      assert_equal @user.photos[0].description, 'テストです'
    end
  end
end
