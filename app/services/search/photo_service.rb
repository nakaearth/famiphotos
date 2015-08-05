module Search
  class PhotoService
    def initialize(search_model_class)
      @client = search_model_class.__elasticsearch__
    end

    # TODO: 柔軟生を出すようんいする.titleがカラムにあるかみるようにsuru
    #
    def search(search_word)
      @client.search(
        query: {
          match: { "description": "#{search_word}" }
        },
        sort: [
          { created_at: "desc" }
        ],
        size: 100
      ).records.to_a
    end
  end
end
