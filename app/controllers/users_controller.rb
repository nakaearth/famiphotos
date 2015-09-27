class UsersController < ApplicationController
  before_action :set_user_search,  only: %i( index show destroy )
  before_action :set_user, only: %i( show edit update destroy )

  def index
    current_group.users
  end

  def show
  end

  def new
    @user = User.new
  end

  def create

  end

  def edit
  end

  def update
  end

  def destroy

  end

  private

  def set_user_search
    @user_search = UserSearch.new
  end

  def set_user
    @user = User.find(Base64.decode64(params[:id]))
  end

  def user_params
  end
end
