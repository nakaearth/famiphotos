# frozen_string_literal: true
class SharedAlbumsController < ApplicationController
  include UserAgent

  before_action :set_request_variant
  before_action :set_shared_album, only: %i(show)

  def show; end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_shared_album
    @shared_album = SharedAlbums.where(id: SharedAlbum.decrypt_id(params[:shared_album_id])).first
  end

  def set_photos
    @shared_photos = @shared_album.photos
  end
end
