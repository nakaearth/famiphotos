require "test_helper"

class Search::Query::FunctionQueryTest < ActiveSupport::TestCase
  setup do
  end

  def test_match_query_for_keyword_paramas
    conditions = { keyword: 'test' }
    query = [
      {
         match: {
           description: {
             query: 'test',
             operator: 'and'
           }
         }
      }
    ] 

    function_query = Search::Query::FunctionQuery.new(conditions, [:description])
    function_query.match_query
    assert_equal function_query.functions, query
  end
  
  def test_term_query_for_user_id
    user = create(:user)
    conditions = { user_id: user.id }.with_indifferent_access
    query = [ {
         term: {
           user_id: user.id
         }
      } ]

    function_query = Search::Query::FunctionQuery.new(conditions, [:user_id])
    function_query.term_query
    assert_equal function_query.functions, query
  end
end

