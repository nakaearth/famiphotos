class PhotosController < ApplicationController
  before_action :set_photo, only: [:new, :edit, :show, :destroy]

  def index
    @photos = @current_user.photos.page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    @photo = @current_user.photos.build(photo_params)

    if @photo.save
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
  end

  private

  def set_photo
    @photo = Photo.new
  end

  def photo_params
    params.require(:photo).permit(:description, :photo)
  end
end
