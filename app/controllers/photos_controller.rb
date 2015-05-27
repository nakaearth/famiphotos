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
    require(params[:photo]).permit(:description, :photo)
  end
end
