# frozen_string_literal: true
module Albums
  class AlbumSearchQuery < Base
    def call(keyword: search_keyword)
      results = Search::AlbumSearchInfrastructure.search(search_keyword)
    end
  end
end
