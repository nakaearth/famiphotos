# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Albums::AlbumSearchQuery do
  describe '.call' do
    let(:user) { create(:user) }
    let(:album) { create(:album, title: 'テスト犬album', user: user) }
    let(:photo) { create(:photo, description: 'これは犬の写真です', album: album) }
    let(:tag) { create(:tag, label_name: '犬', album: album) }

    before do
      tag
      Search::ElasticsearchIndexGateway.create_index('albums')
      Search::AlbumToElasticsearchInsertGateway.bulk('albums')
    end

    context '該当するデータがある場合' do
      let(:params) { { keyword: 'テスト犬' } }

      before do
        @results = Albums::AlbumSearchQuery.call(keyword: params[:keyword], user_id: user.id)
      end

      it '検索結果と検索結果の総数、アグリゲーションの結果が格納されたHashを返す' do
        expect(@results.size).to eq 2
        expect(@results[:result_records].size).to eq 1
        expect(@results[:aggregations].empty?).to eq false
      end
    end
  end
end
