require 'rails_helper'

module Photo
  describe PhotoGeoService do

    describe '#search' do
      subject { Search::PhotoGeoService.new.regist(PhotoGeo) }

      context '緯度経度検索' do

      end
    end
  end
end

