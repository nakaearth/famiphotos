module Search
  class Photo < Base
    def search
      @client.search(query).records.to_a
    end

    private

    def query
      {
        query: {
          function_score: {
            score_mode: 'sum',
            boost_mode: 'multiply',
            query: {
              simple_query_string: {
                query: @conditions[:keyword],
                fields: ['description'],
                default_operator: :and
              }
            },
            functions: [
              {
                filter: {
                  query: {
                    simple_query_string: {
                      query: @conditions[:keyword],
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
                      query: @conditions[:user].try.id,
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
    end
  end
end
