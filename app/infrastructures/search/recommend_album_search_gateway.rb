# frozen_string_literal: true
module Search
  class RecommendAlbumSearchGateway < BaseSearchInfrastructure
    class << self
      def execute(keyword, user_id)
        Elasticsearch::Model.client = client_connection
        album_client = Album.__elasticsearch__
        album_client.index_name = Consts::Elasticsearch[:index_name][:album]
        response = album_client.search(query(keyword, user_id))

        {
          result_records: response.records.to_a,
          results: response.records
        }
      end

      private

      def query(keyword, user_id)
        {
          min_score: 0.1, # 最低scoreの設定
          query: {
            more_like_this: {
              fields: ['title', 'photos.description'],
              like: keyword,
              min_term_freq: 1,
              max_query_terms: 12
            }
          }
        }.to_json
      end
    end
  end
end
