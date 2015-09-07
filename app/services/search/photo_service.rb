module Search
  class PhotoService
    def initialize(search_model_class)
      if search_model_class.columns { |column| column.type == 'text' }.any?
        @client = search_model_class.__elasticsearch__
      else
        fail "Format error: #{search_model_class} do not have text type column"
      end
    end

    def search(photo_search, user)
      @client.search(
        min_score:  0.3,
        query: {
          bool: {
            should: [
              {
                match: { "description": "#{photo_search.search_word}" }
              },
              {
                prefix: { "description": "#{photo_search.search_word}" }
              }
            ]
          }
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
