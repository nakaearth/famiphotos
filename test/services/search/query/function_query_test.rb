require 'test_helper'

class Search::Query::FunctionQueryTest < ActiveSupport::TestCase
  setup do
  end

  def test_keyword_query
    conditions = { keyword: 'test' }
    query = {
         simple_query_string: {
           query: 'test',
           fields: ['description'],
           default_operator: :and
         } 
      }

    assert_equal FunctionQuery.new(conditions, ['description']).keyword_query, query
  end
end

