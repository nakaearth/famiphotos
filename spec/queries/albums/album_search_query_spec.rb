# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Albums::AlbumSearchQuery do
  describe '.call' do
    before do
      Search::ElasticsearchIndexGateway.create_index('albums')
    end

    context '1件だけ指定したユーザが作成したアルバムがある場合' do
      let(:user) { create(:user) }
      let(:album) { create(:album, title: 'テスト犬album', user: user) }
      let(:photo) { create(:photo, description: 'これは犬の写真です',
                           album: album, user: user) }
      let(:tag) { create(:tag, label_name: '犬', album: album) }
      let(:params) { { keyword: '犬' } }

      before do
        tag
        photo
        Search::AlbumToElasticsearchInsertGateway.bulk('albums')
        @results = Albums::AlbumSearchQuery.call(keyword: params[:keyword], user_id: user.id)
      end

      it '検索結果と検索結果の総数、アグリゲーションの結果が格納されたHashを返す' do
        expect(@results.size).to eq 2
        expect(@results[:result_records].size).to eq 1
        expect(@results[:aggregations].empty?).to eq false
      end

      it 'keywordで指定したものが返ってくる' do
        expect(@results[:result_records][0].id).to eq album.id
        expect(@results[:result_records][0].title).to eq album.title
      end
    end

    context '指定したユーザ以外が作成したアルバムもある場合' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:album) { create(:album, title: 'テスト犬album', user: user) }
      let(:photo) { create(:photo, description: 'これは犬の写真です',
                           album: album, user: user) }
      let(:tag) { create(:tag, label_name: '犬', album: album) }
      let(:other_album) { create(:album, title: 'テスト犬album2', user: other_user) }
      let(:other_photo) { create(:photo, description: 'これは最近買った犬の写真です',
                                 album: other_album, user: other_user) }
      let(:other_tag) { create(:tag, label_name: '犬', album: other_album) }

      let(:params) { { keyword: '犬' } }

      before do
        photo
        other_photo
        tag
        other_tag
        Search::AlbumToElasticsearchInsertGateway.bulk('albums')
        @results = Albums::AlbumSearchQuery.call(keyword: params[:keyword], user_id: user.id)
      end

      it '検索結果と検索結果の総数、アグリゲーションの結果が格納されたHashを返す' do
        expect(@results.size).to eq 2
        expect(@results[:result_records].size).to eq 1
        expect(@results[:aggregations].empty?).to eq false
      end

      it 'keywordで指定したものが返ってくる' do
        expect(@results[:result_records][0].id).to eq album.id
        expect(@results[:result_records][0].title).to eq album.title
      end
    end
  end
end
