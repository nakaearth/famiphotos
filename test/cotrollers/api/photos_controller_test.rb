require 'test_helper'

module Api
  class PhotosControllerTest < ActionController::TestCase
    
    def setup
      @user   = create(:user)
      @photos = create_list(:photo, 5, user: @user)
    end

    test 'index controller' do
      get :index
      assert_not_nil assigns[:photos]
      assert_equal @photos.size,  assigns[:photos].size
    end
  end
end
