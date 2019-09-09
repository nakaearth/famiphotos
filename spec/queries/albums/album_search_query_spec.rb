# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Albums::AlbumSearchQuery do
  describe '.call' do
    let(:user) { create(:user) }
    let(:album) { create(:album, title: 'テストalbum', user: user) }
    let(:photo) { create(:photo, description: 'これは犬の写真です', album: album) }
    let(:tag) { create(:tag, label_name: '犬', album: album) }

    before do
      tag
      Search::ElasticsearchIndexGateway.create_index('albums')
      Search::AlbumToElasticsearchInsertGateway.import('albums')
    end

    context '該当するデータがある場合' do
      let(:params) { { keyword: 'テスト' } }

      before do
        @results = Albums::AlbumSearchQuery.call(keyword: params[:keyword], user_id: user.id)
      end

      it { expect(@results.size).to eq 0 }
    end
  end
end
