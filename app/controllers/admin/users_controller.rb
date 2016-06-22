module Admin
  class UsersController < Admin::ApplicationController
    before_action :set_user, only: %i( show edit destroy)

    def index
      @users = Rails.cache.fetch(Consts::CACHE_KEYS[:USER_LIST]) do
        User.page(params[:page])
      end
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(create_params)

      if @user.save
        redirect_to :admin_users_path, notice: '新たにユーザを追加しました'
      else
        render :new
      end
    end

    def edit
    end

    def update
    end

    def destroy
      @user.destroy

      redirect_to admin_users_path, notice: 'お知らせを削除しました'
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def crete_params
      params.require(:user).permit(:name, :email)
    end
  end
end
