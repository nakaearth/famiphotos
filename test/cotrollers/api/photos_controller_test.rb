require 'test_helper'

module Api
  class PhotosControllerTest < ActionController::TestCase
    
    def setup
      create(:user)
      @user = User.all.order(:created_at).last
      create_list(:photo, 5, user: @user, image: 'test/fixtures/test.png')
    end

    test 'index controller' do
      get :index
      assert_not_nil assigns[:photos]
      assert_equal @user.photos.size,  assigns[:photos].size
    end
  end
end
