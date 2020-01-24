# frozen_string_literal: true
module Albums
  class AlbumGroupSearchQuery
    class << self
      def call(keyword:, user_id:)
        results = Search::AlbumGroupSearchGateway.execute(keyword, user_id)
      end
    end
  end
end
