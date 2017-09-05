# frozen_string_literal: true
module Api
  class SharedAlbumsController < Api::ApplicationController
    include EncryptionConcern

    def show
      @shared_album = SharedAlbum.find(SharedAlbum.decrypt_id(params[:id]))
      @shared_photos = @shared_album.album.photos
    end
  end
end
