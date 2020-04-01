# frozen_string_literal: true
module Search
  class AlbumGroupSearchGateway < BaseSearchInfrastructure
    class << self
      def execute(keyword, user_id)
        Elasticsearch::Model.client = client_connection
        group_client = Group.__elasticsearch__
        group_client.index_name = Consts::Elasticsearch[:index_name][:group]
        response = group_client.search(query(keyword, user_id))

        {
          result_records: response.records.to_a,
          results: response.records
        }
      end

      private

      # TODO: QueryBuilder以下に移す
      def query(keyword, owner_user_id)
        {
          # min_score: 0.1, # 最低scoreの設定
          query: {
            function_score: {
              score_mode: 'sum', # functionsのスコアの計算方法
              boost_mode: 'multiply', # クエリの合計スコアとfunctionのスコアの計算方法
              query: {
                bool: {
                  must: [
                    Search::QueryBuilder::FunctionQuery.match_query('owner_user_id', owner_user_id),
                    Search::QueryBuilder::FunctionQuery.full_text_query(['name^7', 'name2^3'], keyword),
                    # Search::QueryBuilder::FunctionQuery.full_text_query(['events.description^7', 'events.description2^3'], keyword),
                  ]
                }
              },
            }
          }
        }.to_json
      end
    end
  end
end
