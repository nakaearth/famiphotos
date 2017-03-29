# frozen_string_literal: true
module Admin
  class PhotosController < ApplicationController
    before_action :set_photo, only: %i(show edit destroy)

    def index
      @photos = Rails.cache.fetch(CACHE_KEYS[:PHOTO_LIST]) do
        Photo.page(params[:page]).to_a
      end
    end

    def show; end

    def edit; end

    def destroy; end
  end
end
