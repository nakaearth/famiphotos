module Search
  class PhotoGeoService < BaseService
    # geo関数を使って位置情報を使った検索
    def search(photo_search, _user)
      body = {
        query: {
          function_score: {
            score_mode: 'sum',
            boost_mode: 'multiply',
            query: {
              simple_query_string: {
                query: photo_search.search_word,
                fields: ['description'],
                default_operator: :and
              }
            },
            functions: [
              {
                filter: {
                  geo_shape: {
                    location: {
                      shape: {
                        type: 'envelope', 
                        coordinates: [[13.0,  53.0],  [14.0,  52.0]]
                      }
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
 
