module Search
  class UserService < BaseService
    def search(user_search, user)
      body =  {
        query: {
          bool: {
            should: [
              {
                match: { name: user_search.search_word }
              },
              {
                match: { nickname: user_search.search_word }
              },
              {
                prefix: { name: user_search.search_word }
              },
              {
                prefix: { nickname: user_search.search_word }
              }
            ]
          }
        },
        filter: {
          bool: {
            should: [
              { term: { "user_id": "#{user.id}" } },
              { term: { "group_id": "#{user.group_id}" } }
            ]
          }
        },
        sort: [
          { created_at: "desc" }
        ],
        size: 100
      }.to_json

      @client.search(body).records.to_a
    end
  end
end
