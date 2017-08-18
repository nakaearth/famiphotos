# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Album, type: :model do
  let!(:user) { create(:user) }
  let(:album) { create(:album, user: user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect have_many(:photos) }
      it { expect belong_to(:user) }
    end
  end

  describe '入力チェックをする' do
    context 'titleカラム' do
      it { is_expected.to validate_length_of(:title).is_at_most(80) }
    end
  end

  describe '#top_image_Url' do
    context 'photosがからの場合' do
      it { expect(album.top_image_url).to eq 'no_photo.jpeg' }
    end

    context 'photosにデータがある場合' do
      let(:photo) { create(:photo, user: user, album: album) }
      before do
        album.photos << photo
        album.save!
      end

      # TODO: 一部mockにしないとテストがだめ
      it { expect(album.top_image_url).to eq album.photos.first.thumb_url }
    end
  end
end
