# frozen_string_literal: true
class SharedAlbumsController < ApplicationController
  include UserAgent

  before_action :set_request_variant
  before_action :set_album, only: %i(create)
  before_action :set_shared_album, only: %i(show)
  before_action :set_photos, only: %i(show)

  def create
    @shared_album = SharedAlbum.create(album: @album, password: random_password)
  end

  def show; end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_album
    @album = Album.find(Album.decrypt_id(params[:shared_album][:album_id]).to_i)
  end

  def set_shared_album
    @shared_album = SharedAlbum.find(SharedAlbum.decrypt_id(params[:id]))
  end

  def set_photos
    @shared_photos = @shared_album.album.photos
  end

  def random_password
    # TODO: ランダムでパスワードを生成
    "hogehoge"
  end
end
