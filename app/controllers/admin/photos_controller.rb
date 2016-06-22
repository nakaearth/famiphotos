module Admin
  class PhotosController < ApplicationController
    before_action :set_photo, only: %i( show edit destroy)

    def index
      @photos = Rails.cache.fetch(Consts::CACHE_KEYS[:PHOTO_LIST]) do
        Photos.page(params[:page])
      end
    end

    def show
    end

    def edit
    end

    def destroy
    end
  end
end
