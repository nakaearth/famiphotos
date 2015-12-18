class PhotosController < ApplicationController
  before_action :set_photo, only: [:edit, :show, :destroy]
  before_action :set_photo_search

  def index
    @photos = @current_user.photos.page(params[:page])
  end

  def show
  end

  def new
    @photo = @current_user.photos.build
  end

  def create
    @photo = @current_user.photos.build(photo_params)

    if Photo.with_writable { @photo.save }
      redirect_to photos_path, notice: '写真の登録がしました'
    else
      render action: :new, alert: '写真の登録に失敗しました'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice: '写真を削除しました'
  end

  private

  def set_photo
    @photo = Photo.find(Base64.decode64(params[:id]))
  end

  def set_photo_search
    @photo_search = PhotoSearch.new
  end

  def photo_params
    # TODO: nested_attributを使う
    colums_name = [
      :description,
      :photo,
      photo_geo_attributes: [
        :address
      ]
    ]

    params.require(:photo).permit(colums_name)
  end
end
