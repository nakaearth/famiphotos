# frozen_string_literal: true
module Albums
  class AlbumSearchQuery
    class << self
      def call(keyword:)
        results = Search::AlbumSearchInfrastructure.call(keyword)
      end
    end
  end
end
