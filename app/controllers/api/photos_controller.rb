module Api
  class PhotosController < Api::ApplicationController
    include EncryptionConcern

    before_action :set_user
    before_action :set_photo, only: %i( update show )

    # 写真一覧をjson形式で返す
    def index
      @photos = @current_user.photos

      render json: @photos
    end

    def show
      render json: @photo
    end

    # 写真を投稿する
    def create
      ActiveRecord::Base.transaction do
        Photos::UploadService.execute(@current_user, photo_params)

        head :ok, { status: 'ok' }
      end
    rescue => e
      logger.error e.message
      head :internal_server_error
    end

    def update
    end

    private

    def set_user
      @current_user = User.find_by(uid: encrypted_by(params[:uid]))
    rescue
      head :not_found
    end

    def set_photo
      @photo = @current_user.photos.find_by(id: encrypted_by(params[:photo_id]))
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
