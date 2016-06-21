module Admin
  class PhotosController < ApplicationController
    before_action :set_photo, only: %i( show edit destroy)

    def index
      @photos = Photos.page(params[:page])
    end

    def show
    end

    def edit
    end

    def destroy
    end
  end
end
