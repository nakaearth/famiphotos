module Search
  module Query
    class FunctionQuery < Function
      def keyword_query
        {
          simple_query_string: {
            query: @conditions[:keyword],
            fields: @fields,
            default_operator: :and
          } 
        }
      end

      def user_id_query
        {
          simple_query_string: {
            query: @conditions[:user].try.id,
            fields: @fields,
            default_operator: :and
          } 
        }
      end

      def query_for(condition_param_name)
        define_method "#{method_name}_query" do
          {
             simple_query_string: {
               query: @conditions[condition_param_name],
               fields: @fields,
               default_operator: :and
             } 
          }           
        end
      end
    end
  end
end
