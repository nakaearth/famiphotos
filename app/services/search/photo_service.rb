module Search
  class PhotoService < BaseService
    def search(photo_search, user)
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
                  query: {
                    simple_query_string: {
                      query: photo_search.search_word,
                      fields: ['description'],
                      default_operator: :and
                    }
                  }
                },
                weight: 5
              },
              {
                filter: {
                  query: {
                    simple_query_string: {
                      query: user.id,
                      fields: ['user_id'],
                      default_operator: :and
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
