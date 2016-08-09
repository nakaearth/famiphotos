require "test_helper"

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
  
  def test_user_id_query
    user = create(:user)
    conditions = { user: user  }
    query = {
         simple_query_string: {
           query: 1,
           fields: ['user_id'],
           default_operator: :and
         }
      }

    # assert_equal FunctionQuery.new(conditions, ['user_id']).user_id_query, query
  end
end

