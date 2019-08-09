# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Albums::AlbumSearchQuery do
  let(params) do
    {
      keyword: 'これはテスト',
    }
  end

  let(:user) { create(:user) }

  describe '.call' do
    context '該当するデータがある場合' do
      before do
        @results = Albums::AlbumSearchQuery.call(params)
      end

      it { expect(@results.size).to eq 0 }
    end
  end
end
