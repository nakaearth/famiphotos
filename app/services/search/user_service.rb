module Search
  class UserService < BaseService
    def search

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


  end
end
