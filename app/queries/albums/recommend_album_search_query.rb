module Albums
  class RecommendAlbumSearchQuery
    class << self
      def call(keyword:, user_id:)
        results = Search::RecommendAlbumSearchGateway.execute(keyword, user_id)
      end
    end
  end
end
