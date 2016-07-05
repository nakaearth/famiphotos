module Search
  module AbRoadApi
    class Spot
      # area_codeやcountries、citiesをレコメンドエンジンから取得して
      # keywordとプラスで検索する
      attr_accessor :area_codes, :countries, :cities, :keyword

      def search
        Settings.api[:url]
      end
    end
  end
end
