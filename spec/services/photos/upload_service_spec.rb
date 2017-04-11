# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Photos::UploadService, broken: true do
  let(:photo_params) do
    {
      description: 'これはテスト',
      image: File.open("#{Rails.root}/spec/fixtures/dog.jpeg")
    }
  end

  let(:group) { create(:group) }
  let(:user) { create(:user, group: group) }

  describe 'file_upload' do
    before do
      group
      user
      Photos::UploadService.execute(user, photo_params)
    end

    context '地域情報なし' do
      it { expect(user.photos.count).to be > 0 }
    end

    # TODO: nested_attributeの動きが違う？要確認!!!!
    # context '地域情報あり' do
    #   before do
    #     photo_params.merge!({ photo_geo_attributes: { address: '東京都渋谷区' } })
    #   end
    #
    #   it { expect(user.photos.count).to be > 0 }
    #   it '' do
    #     binding.pry
    #     expect(user.photos.last.photo_geo).not_to be_nil
    #   end
    #   # it { expect(user.photos.last.photo_geo).not_to be_nil }
    # end
  end

  describe '例外' do
    context 'file_upload_error' do
      let(:photo_params) do
        {
          description: 'これはテスト',
          image: File.open("#{Rails.root}/spec/fixtures/test.txt")
        }
      end

      it { expect { Photos::UploadService.execute(user, photo_params) }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
