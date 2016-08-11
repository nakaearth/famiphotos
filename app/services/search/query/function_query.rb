module Search
  module Query
    class FunctionQuery < Function
      def functions
        @functions
      end

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
      end
    end
  end
end
