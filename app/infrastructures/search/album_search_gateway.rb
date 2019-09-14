# frozen_string_literal: true
module Search
  class AlbumSearchGateway < BaseSearchInfrastructure
    class << self
      def execute(keyword, user_id)
        Elasticsearch::Model.client = client_connection
        album_client = Album.__elasticsearch__
        album_client.index_name = Consts::Elasticsearch[:index_name][:album]
        response = album_client.search(query(keyword, user_id))

        {
          result_records: response.records.to_a,
          aggregations: response.aggregations,
        }
      end

      private

      # TODO: QueryBuilder以下に移す
      def query(keyword, user_id)
        {
          min_score: 0.5, # 最低scoreの設定
          query: {
            function_score: {
              score_mode: 'sum', # functionsのスコアの計算方法
              boost_mode: 'multiply', # クエリの合計スコアとfunctionのスコアの計算方法
              query: {
                bool: {
                  must: [
                    Search::QueryBuilder::FunctionQuery.match_query('user_id', user_id),
                    Search::QueryBuilder::FunctionQuery.full_text_query('title', keyword)
                  ]
                }
              },
              functions: [
                {
                  field_value_factor: {
                    field: "total_point",
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
                field: 'label_name',
                size: 50
              }
            }
          }
        }.to_json
      end
    end
  end
end
