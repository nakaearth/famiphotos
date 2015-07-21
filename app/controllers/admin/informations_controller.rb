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
    end

    def destroy
      @information.destroy

      redirect_to admin_informations_path, notice: 'お知らせを削除しました'
    end

    private

    def set_information
      @information = Information.find(params[:id])
    end
  end
end
