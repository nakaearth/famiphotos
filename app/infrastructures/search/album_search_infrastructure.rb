# frozen_string_literal: true
module Search
  class AlbumSearchInfrastructure < BaseSearchInfrastructure
    class << self
      def call(keyword, user_id)
        Elasticsearch::Model.client = client
        @client = Album.__elasticsearch__
        @client.index_name = Consts::Elasticsearch[:index_name][:album]
        response = @client.search(query(keyword, user_id))
        {
          result_records: response.records.to_a,
          result_count: response.records,
          aggregations: response.aggregations,
        }
      end

      private

      # TODO: QueryBuilder以下に移す
      def query(keyword, user_id)
        {
          min_score: 20,
          query: {
            function_score: {
              score_mode: 'sum', # functionsないのスコアの計算方法
              boost_mode: 'multiply', # クエリの合計スコアとfunctionのスコアの計算方法
              query: {
                bool: {
                  must: [
                    Search::Query::FunctionQuery.match_query('user_id', user_id),
                    Search::Query::FunctionQuery.full_text_query('description', keyword)
                  ]
                }
              },
              functions: [
                {
                  field_value_factor: {
                    field: "good_point",
                    factor: 2.0,
                    modifier: "square",
                    missing: 1
                  },
                  weight: 5
                },
                {
                  field_value_factor: {
                    field: "id",
                    factor: 3,
                    modifier: "sqrt", # squt: ルート, log: 指数関数
                    missing: 1
                  },
                  weight: 2
                }
              ]
            }
  # TODO: aggregationを設定する
          },
          aggs: {
            tag: {
              terms: {
                field: 'tag_name',
                size: 50
              }
            }
          }
        }.to_json
      end
    end
  end
end
