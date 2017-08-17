# frozen_string_literal: true
class AlbumsController < ApplicationController
  include UserAgent

  before_action :set_request_variant
  before_action :set_album, only: %i(show edit destroy)
  before_action :exists_current_group?, only: %i(new create)

  def index
    # groupの設定がそもそもない時は即return
    return unless @current_group

    # デフォルトのグループのアルバム
    @albums = @current_group.albums.page(params[:page])

    # デフォルト以外のグループのアルバム
    @other_group_albums = @current_user.albums_without_this_group(@current_group)
  end

  def show; end

  def new
    @album = @current_group.albums.build
  end

  def create
    @album = @current_group.albums.build(album_params)

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
    @album = @current_group.albums.where(id: Album.decrypt_id(params[:album_id])).first
  end

  def exists_current_group?
    return redirect_to new_group_path unless @current_group
  end

  def album_params
    colums_name = [
      :title
    ]

    params.fetch(:group, {}).fetch(:album, {}).permit(colums_name)
  end
end
