module Search
  class PhotoService
    def initialize(search_model_class)
      @client = search_model_class.__elasticsearch__
    end

    # TODO: 柔軟生を出すようんいする.titleがカラムにあるかみるようにsuru
    #
    def search(photo_search, user)
      @client.search(
        min_score:  0.3,
        query: {
          match: { "description": "#{photo_search.search_word}" }
        },
        filter: {
          term: { "user_id": "#{user.id}" }
        },
        sort: [
          { created_at: "desc" }
        ],
        size: 100
      ).records.to_a
    end
  end
end
