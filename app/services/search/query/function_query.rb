module Search
  module Query
    class FunctionQuery < Function
      def match_query
        @fields.each do |field|
          @functions <<
            {
              match: {
                "#{field}": {
                  query: @conditions[:keyword],
                  operator: 'and'
                }
              }
            }
        end

        @functions
      end

      def term_query
        @fields.each do |field|
          @functions <<
            {
              term: {
                "#{field}": @conditions["#{field}"]
              }
            }
        end

        @functions
      end
    end
  end
end
