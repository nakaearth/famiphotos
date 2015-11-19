require 'rails_helper'

module Photo
  describe PhotoGeoService do
    let(:photo_geos) { create_list(:photo_geo, 10, address: '東京都渋谷区') }
    let(:photo_search) { PhotoSearch.new }

    describe '#search' do
      subject(:searched_photo_geos) { Search::PhotoGeoService.new(PhotoGeo).search(photo_search) }

      before do
        photo_geos
        photo_search.distance = '200km'
        photo_search.lat = 135
        photo_search.log = 45
      end

      context '緯度経度検索' do
        it { expect(:search_photo_geos).not_to be_nil } 
      end
    end
  end
end
