require 'rails_helper'

module Photo
  describe UploadService do
    let(:user) { create(:user) }
    let(:param) {
      {
        photo: 'spec/fixtures/test.jpg',
        description: 'これはテスト',
        photo_geo_attributes: [
          address: '東京都渋谷区'
        ]
      }
    }

    context '#upload' do
      before do
        Photo::UploadService.execute(user, param)

        user.reload
      end

      it{ expect(user.photos).not_to be_nil }
    end
  end
end

