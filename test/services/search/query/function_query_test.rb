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
    assert_equal function_query.match_query, query
  end
 
  def test_match_query_for_keyword_paramas_with_multi_column
    conditions = { keyword: 'test' }
    query = [
      {
         match: {
           description: {
             query: 'test',
             operator: 'and'
           }
         }
      },
      {
         match: {
           title: {
             query: 'test',
             operator: 'and'
           }
         }
      }
    ] 

    function_query = Search::Query::FunctionQuery.new(conditions, [:description, :title])
    assert_equal function_query.match_query, query
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
    assert_equal function_query.term_query, query
  end
  
  def test_term_query_for_user_id_with_multi_column
    user  = create(:user)
    group = create(:group)

    conditions = { user_id: user.id, group_id: group.id }.with_indifferent_access
    query = [
      {
         term: {
           user_id: user.id
         }
      },
      {
         term: {
           group_id: group.id
         }
       }
      ]

    function_query = Search::Query::FunctionQuery.new(conditions, [:user_id, :group_id])
    assert_equal function_query.term_query, query
  end
end

