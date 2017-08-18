# frozen_string_literal: true
class AlbumsController < ApplicationController
  include UserAgent

  before_action :set_request_variant
  before_action :set_album, only: %i(show edit destroy)

  def index
    # デフォルトのグループのアルバム
    @albums = @current_user.albums.page(params[:page])
  end

  def show; end

  def new
    @album = @current_user.albums.build
  end

  def create
    @album = @current_user.albums.build(album_params)

    if @album.save
      redirect_to albums_path, notice: 'アルバムを作成しました'
    else
      redirect_to action: :new, alert: 'アルバム作成に失敗しました'
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_album
    @album = @current_user.albums.where(id: Album.decrypt_id(params[:album_id])).first
  end

  def album_params
    colums_name = [
      :title
    ]

    params.fetch(:user, {}).fetch(:album, {}).permit(colums_name)
  end
end
