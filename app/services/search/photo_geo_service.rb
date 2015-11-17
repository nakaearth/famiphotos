module Search
  class PhotoGeoService < BaseService
    # geo関数を使って位置情報を使った検索
    def search(photo_search, _user)
      body = {

      }.to_json

      @client.search(body).records.to_a
    end
  end
end
 
