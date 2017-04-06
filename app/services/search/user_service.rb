# frozen_string_literal: true
module Search
  class UserService < Base
    def search(user_search, _user)
      body = {
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
        # filter: {
        #  bool: {
        #    should: [
        #      { term: { "user_id": "#{user.id}" } }
        #    ]
        #  }
        # },
        sort: [
          { created_at: 'desc' }
        ],
        size: 100
      }.to_json

      @client.search(body).records.to_a
    end
  end
end
