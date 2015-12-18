require 'rails_helper'

module Search
  describe PhotoGeoService do
    let(:photo_geos) { create_list(:photo_geo, 10, address: '東京都渋谷区') }
    let(:photo_geo_search) { PhotoGeoSearch.new }

    describe '#search' do
      subject(:searched_photo_geos) { Search::PhotoGeoService.new(PhotoGeo).search(photo_geo_search) }

      before do
        photo_geos
        photo_geo_search.distance = '200km'
        photo_geo_search.address = '東京都渋谷区'
      end

      context '緯度経度検索' do
        it { expect(:search_photo_geos).not_to be_nil }
      end
    end
  end
end
