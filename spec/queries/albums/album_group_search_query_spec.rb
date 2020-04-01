# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Albums::AlbumGroupSearchQuery do
  describe '.call' do
    before do
      Search::ElasticsearchIndexGateway.create_index('albums')
    end

    context '1件だけ指定したユーザが作成したアルバムがある場合' do
      let(:user) { create(:user) }
      let(:params) { { keyword: 'グループ' } }

      before do
        group = create(:group, owner_id: user.id, name: 'myFamilyグループ')
        group_child = create(:group, :child, owner_id: user.id,
                             dir_id: group.id, name: 'テストグループ')

        Search::GroupToElasticsearchInsertGateway.bulk('groups')
        @results = Albums::AlbumGroupSearchQuery.call(keyword: params[:keyword], user_id: user.id)
      end

      it '検索結果と検索結果の総数が格納されたHashを返す' do
        expect(@results.size).to eq 2
        expect(@results[:result_records].size).to eq 1
      end

      it 'keywordで指定したものが返ってくる' do
        @group = Group.all.first
        expect(@results[:result_records][0].id).to eq @group.id
        expect(@results[:result_records][0].title).to eq @group.title
      end
    end
  end
end
