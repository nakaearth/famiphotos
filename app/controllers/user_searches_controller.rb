# frozen_string_literal: true
class UserSearchesController < ApplicationController
  before_action :set_user_search

  def create
    service       = Search::UserService.new(User)
    @result_users = service.search(@user_search, current_user)

    @users        = current_group.users
  end

  private

  def set_user_search
    @user_search = UserSearch.new(user_params)
  end

  def user_params
    user_params = [
      :search_word
    ]

    params.fetch(:user_search, {}).permit(user_params)
  end
end
