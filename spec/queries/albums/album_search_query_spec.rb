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
        expect(@results.size).to eq 3
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
        expect(@results.size).to eq 3
        expect(@results[:result_records].size).to eq 1
        expect(@results[:aggregations].empty?).to eq false
      end

      it 'keywordで指定したものが返ってくる' do
        expect(@results[:result_records][0].id).to eq album.id
        expect(@results[:result_records][0].title).to eq album.title
      end
    end

    context '指定したユーザが複数のアルバムを作成していた場合' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:album1) { create(:album, title: test_album_title1, user: user) }
      let(:photo1_1) { create(:photo, description: test_photo_description1_1,
                              album: album1, user: user) }
      let(:photo1_2) { create(:photo, description: test_photo_description1_2,
                              album: album1, user: user) }
      let(:album2) { create(:album, title: test_album_title2, user: user) }
      let(:photo2_1) { create(:photo, description: test_photo_description2_1,
                           album: album, user: user) }
      let(:album3) { create(:album, title: test_album_title3, user: user) }
      let(:tag) { create(:tag, label_name: '犬', album: album1) }
      let(:other_user_album) { create(:album, title: other_album_title, user: other_user) }
      let(:other_user_photo) { create(:photo, description: other_photo_description,
                                 album: other_album, user: other_user) }
      let(:other_tag) { create(:tag, label_name: '犬', album: other_user_album) }

      let(:params) { { keyword: keyword } }

      context 'kuromojiの辞書に無い単語で検索する場合' do
        let(:test_album_title1) { '映画仮面ライダーとホゲホゲ星人の戦い' }
        let(:test_photo_description1_1) { '戦いの場面1' }
        let(:test_photo_description1_2) { '戦いの場面2' }
        let(:test_album_title2) { 'ターミネータ VS 仮面ライダー' }
        let(:test_photo_description1_1) { 'メイクアップ写真' }
        let(:test_album_title3) { '新宿料理日記' }
        let(:other_album_title) { 'ホゲホゲ星人の冒険' }
        let(:other_photo_description) { '冒険の記録1' }
        let(:keyword) { 'ホゲホゲ星人' }

        before do
          album1
          album2
          album3
          other_user_album
          tag
          other_tag
          Search::AlbumToElasticsearchInsertGateway.bulk('albums')
          @results = Albums::AlbumSearchQuery.call(keyword: params[:keyword], user_id: user.id)
        end

        it '検索結果と検索結果の総数、アグリゲーションの結果が格納されたHashを返す' do
          expect(@results.size).to eq 3
          expect(@results[:result_records].size).to eq 1
          expect(@results[:aggregations].empty?).to eq false

          @results[:results].each_with_hit do |album, hit|
            puts "\n#{album.title}: #{hit._score}"
          end
        end

        it 'keywordで指定したものが返ってくる' do
          expect(@results[:result_records][0].id).to eq album1.id
          expect(@results[:result_records][0].title).to eq album1.title
        end
      end

      context '辞書にもある単語で検索する場合' do
        let(:test_album_title1) { '映画仮面ライダーとホゲホゲ星人の戦い' }
        let(:test_photo_description1_1) { '戦いの場面1' }
        let(:test_photo_description1_2) { '戦いの場面2' }
        let(:test_album_title2) { 'ターミネータ VS 仮面ライダー' }
        let(:test_photo_description1_1) { 'メイクアップ写真' }
        let(:test_album_title3) { '新宿料理日記' }
        let(:other_album_title) { 'ホゲホゲ星人の冒険' }
        let(:other_photo_description) { '冒険の記録1' }
        let(:keyword) { '仮面' }

        before do
          album1
          album2
          album3
          other_user_album
          tag
          other_tag
          Search::AlbumToElasticsearchInsertGateway.bulk('albums')
          @results = Albums::AlbumSearchQuery.call(keyword: params[:keyword], user_id: user.id)
        end

        it '検索結果と検索結果の総数、アグリゲーションの結果が格納されたHashを返す' do
          expect(@results.size).to eq 3
          expect(@results[:result_records].size).to eq 2
          expect(@results[:aggregations].empty?).to eq false

          @results[:results].each_with_hit do |album, hit|
            puts "\n#{album.title}: #{hit._score}"
          end
        end

        it 'keywordで指定したものが返ってくる' do
          expect(@results[:result_records][0].id).to eq album1.id
          expect(@results[:result_records][0].title).to eq album1.title
          expect(@results[:result_records][1].id).to eq album2.id
          expect(@results[:result_records][1].title).to eq album2.title
        end
      end

    end
  end
end
