# frozen_string_literal: true
module Albums
  class AlbumSearchQuery
    class << self
      def call(keyword:, user_id:)
        results = Search::AlbumSearchGateway.execute(keyword, user_id)
      end
    end
  end
end
