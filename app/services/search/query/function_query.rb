module Search
  module Query
    class FunctionQuery < Function
      def query
        {
          simple_query_string: {
            query: @conditions[:keyword],
            fields: @fields,
            default_operator: :and
          } 
        }
      end
    end
  end
end
