module Search
  class PhotoService
    def initialize(search_model_class)
      if search_model_class.columns { |column| column.type == 'text' }.any?
        @client = search_model_class.__elasticsearch__
      else
        fail "Format error: #{search_model_class} do not have text type column"
      end
    end

#    def search(photo_search, user)
#      body =  {
#        query: {
#          bool: {
#            should: [
#              {
#                match: { description: photo_search.search_word }
#              },
#              {
#                prefix: { description: photo_search.search_word }
#              }
#            ]
#          }
#        },
#        filter: {
#          term: { "user_id": "#{user.id}" }
#        },
#        sort: [
#          { created_at: "desc" }
#        ],
#        size: 100
#      }.to_json
#
#      @client.search(body).records.to_a
#    end

    def search(photo_search, user)
      body = { 
        query: {
         function_score: {
           score_mode: 'sum',
           boost_mode: 'multiply', 
           query: {
             simple_query_string: {
               query: photo_search.search_word,
               fields: ['description'],
               default_operator: :and,
             }
           },
           functions: [
             {
                filter: {
                  query: {
                    simple_query_string: {
                      query: photo_search.search_word,
                      fields: ['description'],
                       default_operator: :and,
                    }
                  }
                },
                weight: 5
             },
             {
                field_value_factor: {
                  field: "id",
                  factor: 1.2,
                  modifier: "sqrt",
                  missing: 1
                }
             }
           ]
         }
        }
      }.to_json

      @client.search(body).records.to_a
    end
  end
end
