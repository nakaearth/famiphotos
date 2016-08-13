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
            query: { FunctionQuery.new(@conditions, ['description']).match_query },
            functions: [
              {
                filter: {
                  query: { FunctionQuery.new(@conditions, ['user_id']).term_query }
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
