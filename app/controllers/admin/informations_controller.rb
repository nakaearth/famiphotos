module Admin
  class InformationsController < Admin::ApplicationController
    before_action :set_information, only: [:show, :destroy]

    def index
      @informations = Information.all
    end

    def show
    end

    def new
      @information = Information.new
    end

    def create
      @information = Information.new(create_params)

      if @information.save
        redirect_to :admin_informations_path, notice: '新たにお知らせを追加しました'
      else
        render :new
      end
    end

    def destroy
      @information.destroy

      redirect_to admin_informations_path, notice: 'お知らせを削除しました'
    end

    private

    def set_information
      @information = Information.find(params[:id])
    end

    def crete_params
      params.require(:information).permit(:title, :message)
    end
  end
end
