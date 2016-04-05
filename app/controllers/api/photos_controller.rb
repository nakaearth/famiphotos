module Api
  class PhotosController < Api::ApplicationController
    include DecryptedUid

    before_action :set_user

    # 写真一覧をjson形式で返す
    def index
      @photos = @current_user.photos

      render json: @photos
    end

    # 写真を投稿する
    def create
      ActiveRecord::Base.transaction do
        Photos::UploadService.execute(@current_user, photo_params)

        render json: @photo
      end
    rescue => e
      logger.error e.message
      head :internal_server_error
    end

    def update
    end

    private

    def set_user
      @current_user = User.find_by(uid: params[:uid])
    rescue
      head :not_found
    end

    def photo_params
      columns_name = [
        :description,
        :image, 
        photo_geo_attributes: [
          :address
        ]
      ]

      params.require(:photo).permit(columns_name)
    end
  end
end
