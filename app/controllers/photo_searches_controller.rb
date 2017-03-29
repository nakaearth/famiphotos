class PhotoSearchesController < ApplicationController
  def create
    @photos = Search::Photo.new(Photo, photo_search_params).search
  end

  private

  def photo_search_params
    photo_params = [
      :keyword
    ]

    params.fetch(:photo_search).permit(photo_params).merge({ user: current_user })
  end
end
