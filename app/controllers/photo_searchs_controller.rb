class PhotoSearchsController < ApplicationController
  before_action :set_photo_search

  def create
    service = Search::PhotoService.new
    @photos = service.search(@photo_search, current_user)
  end

  private

  def set_photo_search
    @photo_search = PhotoSearch.new(photo_params)
  end

  def photo_params
    photo_params = [
      :search_word
    ]

    params.fetch(:photo_search).permit(photo_params)
  end
end
