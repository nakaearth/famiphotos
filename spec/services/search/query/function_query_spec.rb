# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Search::Query::FunctionQuery do
  describe 'full_text_query' do
    before do
      @expected_query =
        {
          simple_query_string: {
            query: 'test',
            fields: ['description'],
            default_operator: 'and'
          }
        }
    end

    it 'simply_query_stringのqueryが出力される' do
      query = Search::Query::FunctionQuery.full_text_query('description', keyword)
      expect(query).to eq @expected_query
    end
  end

  describe 'match_query' do
    let(:user) { create(:user) }

    before do
      @expected_query =
        {
          term: {
            user_id: user.id
          }
        }
    end

    it 'simply_query_stringのqueryが出力される' do
      query = Search::Query::FunctionQuery.match_query('user_id', user.id)
      expect(query).to eq @expected_query
    end
  end
end
