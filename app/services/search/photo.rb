module Search
  class Photo < Base
    def search
      @client.search(query).records.to_a
    end

    private

    def query
      {
        min_score: 0.5,
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
# TODO: aggregationを設定する
        # },
        # args: {
        #   
        } 
      }.to_json
    end
  end
end
