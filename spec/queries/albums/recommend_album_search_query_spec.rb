# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Albums::RecommendAlbumSearchQuery do
  describe '.call' do
    before do
      Search::ElasticsearchIndexGateway.create_index('albums')
    end

    context '指定したユーザが複数のアルバムを作成していた場合' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:album1) { create(:album, title: '映画仮面ライダーとホゲホゲ星人の戦い', user: user) }
      let(:photo1_1) { create(:photo, description: 'ホゲホゲ星人との場面1です。これは仮面ライダーがXXしているところです',
                              album: album1, user: user) }
      let(:photo1_2) { create(:photo, description: 'ホゲホゲ星人との場面2です',
                               album: album1, user: user) }
      let(:album2) { create(:album, title: 'ターミネータVS仮面ライダー', user: user) }
      let(:photo2_1) { create(:photo, description: 'ターミネータとホゲホゲ星人の戦いの場面',
                              album: album2, user: user) }
      let(:photo2_2) { create(:photo, description: 'ホゲホゲ星人を助ける仮面ライダーの場面',
                              album: album2, user: user) }
      let(:album3) { create(:album, title: '鉄仮面のライダー', user: user) }
      let(:album4) { create(:album, title: 'ライダーが仮面を被ったら', user: user) }
      let(:album5) { create(:album, title: '仮面を被ったライダーの写真', user: user) }
      let(:photo5_1) { create(:photo, description: 'ライダーの写真',
                              album: album5, user: user) }
      let(:album6) { create(:album, title: 'ライダーの写真集', user: user) }
      let(:photo6_1) { create(:photo, description: '仮面をつけたライダーも写ってます',
                              album: album6, user: user) }
      let(:other_album) { create(:album, title: 'ホゲホゲ星人の冒険', user: other_user) }
      let(:other_photo) { create(:photo, description: '冒険の記録1',
                                  album: other_album, user: other_user) }
      let(:tag) { create(:tag, label_name: '犬', album: album1) }
      let(:other_tag) { create(:tag, label_name: '犬', album: other_album) }

      context 'titleとdescriptinの両方にヒットするワードで検索した場合' do
        let(:keyword) { 'ライダー' }

        before do
          photo1_1
          album2
          album3
          album4
          album5
          photo6_1
          other_photo
          tag
          other_tag
          Search::AlbumToElasticsearchInsertGateway.bulk('albums')
          @results = Albums::RecommendAlbumSearchQuery.call(keyword: keyword, user_id: user.id)
        end

        it '検索結果と検索結果の総数、アグリゲーションの結果が格納されたHashを返す' do
          expect(@results.size).to eq 2
          expect(@results[:result_records].size).to eq 5

          puts 'keyword: ライダー'
          @results[:results].each_with_hit do |album, hit|
            puts "\n#{album.title}: #{hit._score}"
          end
        end
      end
    end
  end
end
