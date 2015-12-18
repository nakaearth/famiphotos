module Api
  class PhotosController < Api::ApplicationController
    includes DecryptedUid

    before_action :set_user

    # ajaxで通信したお知らせの一覧をjson形式で返す
    def index
      @photos = current.photos

      render json: @phtos
    end

    def create
      ActiveRecord::Bae.transaction do
        Photo::UploadService.execute(@current_user, photo_params)

        render json: @photo
      end
    rescue
      head 500
    end

    def update
    end

    private

    def set_user
      @current_user = User.find_by(uid: @uid)
    rescue
      head 404
    end

    def photo_params
      columns_name = [
        :photo,
        :description,
        photo_geo_attributes: [
          :address
        ]
      ]

      params.require(:photo).permit(columns_name)
    end
  end
end
