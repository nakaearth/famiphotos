# frozen_string_literal: true
module Search
  module Query
    class FunctionQuery
      class << self
        def match_query(field_name, value)
          { term: { field_name.to_sym => value } }
        end

        def full_text_query(field_name, keyword)
          {
            simple_query_string: {
              query: keyword,
              fields: [field_name],
              default_operator: 'and'
            }
          }
        end
      end
    end
  end
end
