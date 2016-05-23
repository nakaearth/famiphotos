module Search
  class PhotoGeoService < BaseService
    # geo関数を使って位置情報を使った検索
    def search(_photo_gro_search)
      body = {
        query: {
          function_score: {
            score_mode: 'sum',
            boost_mode: 'multiply',
            query: {
              simple_query_string: {
                query: photo_geo_search.address,
                fields: ['address'],
                default_operator: :and
              }
            },
            functions: [
              {
                filter: {
                  geo_distance: {
                    distance: photo_geo_search.distance,
                    'pin.location': {
                      lat: photo_geo_search.lat,
                      lot: photo_geo_search.lot
                    }
                  }
                },
                weight: 5
              },
              {
                field_value_factor: {
                  field: "id",
                  factor: 1.2,
                  modifier: "sqrt",
                  missing: 1
                }
              }
            ]
          }
        }
      }.to_json

      @client.search(body).records.to_a
    end
  end
end
