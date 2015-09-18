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
        query: {
          function_score: {
            score_mode: 'multiply', 
            query: {
              simple_query_string: {
              query: photo_search.search_word,
              fields: ['description'],
              default_operator: :and,
#               bool: {
#                should: [
#                  {
#                    match: { "description": "#{photo_search.search_word}" }
#                  },
#                  {
#                    prefix: { "description": "#{photo_search.search_word}" }
#                  }
#                ]
              
            }, 
            functions: [
              {
                filter: {
                query: {
                  simple_query_string: {
                    query: photo_search.search_word,
                    fields: ['description'],
                  }
                }
              },
              weight: 5  
              }
            ]
            }
          }
        },
        highlight: { fields: { description: { } }}, 
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
