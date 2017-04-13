# frozen_string_literal: true
module Search
  class Photo < Base
    def search
      @client.index_name = Consts::Elasticsearch[:index_name][:photo]
      @client.search(query).records.to_a
    end

    private

    def query
      {
        min_score: 0.1,
        query: {
          function_score: {
            score_mode: 'sum', # functionsないのスコアの計算方法
            boost_mode: 'multiply', # クエリの合計スコアとfunctionのスコアの計算方法
            query: Search::Query::FunctionQuery.new(@conditions, ['description']).match_query,
            functions: [
              {
            #    filter: {
                  field_value_factor: {
                    field: "good_point",
                    factor: 2.0,
                    modifier: "square",
                    missing: 1
                  },
            #    },
                weight: 20
              },
              {
            #    filter: {
                  field_value_factor: {
                    field: "id",
                    factor: 1.5,
                    modifier: "sqrt",
                    missing: 1
                  }
                },
                weight: 10
            #  }
            ]
          }
# TODO: aggregationを設定する
        },
        # args: {
        #   tag: {
        #     terms: {
        #       field: 'tag_name',
        #       size: 50
        #     }
        #   }
        # }
      }.to_json
    end
  end
end
