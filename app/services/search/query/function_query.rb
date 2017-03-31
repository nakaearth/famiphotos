# frozen_string_literal: true
module Search
  module Query
    class FunctionQuery < Function
      def match_query
        {
          simple_query_string: {
            query: @conditions[:keyword],
            fields: [@fields.join(',').to_s],
            default_operator: 'and'
          }
        }
      end

      def term_query
        {
          simple_query_string: {
            query: @conditions[:keyword],
            fields: [@fields.join(',').to_s],
            default_operator: 'and'
          }
        }
      end
    end
  end
end
