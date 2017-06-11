# frozen_string_literal: true
class VideosController < ApplicationController
  include UserAgent
  include DecryptedId

  before_action :set_request_variant
  before_action :set_album, only: %i(index)
  before_action :set_video, only: %i(edit show destroy)

  def index
    respond_to do |format|
      @videos = @album.videos.page(params[:page])
      format.html

      format.json { render 'api/videos/index' }
    end
  end

  def show
    render partial: 'show', format: :html
  end

  def close
    @videos = @current_user.videos.page(params[:page])

    render partial: 'close', format: :html
  end

  def new
    @video = @current_user.videos.build

    @albums = @current_group.albums
  end

  def create
    @video = @current_user.videos.build(photo_params)

    if Photo.with_writable { @video.save }
      redirect_to album_videos_path(album_id: @video.album.id), notice: '写真の登録がしました'
    else
      @albums = @current_group.albums

      render action: :new, alert: '写真の登録に失敗しました'
    end
  end

  def edit; end

  def update; end

  def destroy
    @video.destroy

    redirect_to videos_path, notice: '写真を削除しました'
  end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_album
    @album = @current_group.albums.where(id: params[:album_id]).first
  end

  def set_video
    @video = Photo.find(arams[:id])
  end

  def video_params
    colums_name = [
      :album_id,
      :image,
      tags_attributes: [
        :name
      ]
    ]

    params.require(:video).permit(colums_name)
  end
end
