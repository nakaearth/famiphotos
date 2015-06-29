module Api
  class InformationsController < ApplicationController
    # ajaxで通信したお知らせの一覧をjson形式で返す
    def index
      @informations = Information.all

      render json: @informations
    end

    def create
      ActiveRecord::Bae.transaction do
        @information = Information.create(title: params[:title], message: params[:message])
        render json: @information
      end
    rescue
      head 500
    end
  end
end
