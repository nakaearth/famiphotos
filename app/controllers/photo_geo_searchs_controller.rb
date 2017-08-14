# frozen_string_literal: true
class PhotoGeoSearchsController < ApplicationController
  before_action :set_photo_geo_search

  def create
    photo_service = Photos::GeoSearch.new(Photo)
    @photos       = photo_service.search(@photo_geo_search)
  end

  private

  def set_photo_geo_search
    @photo_geo_search = PhotoGeoSearch.new(photo_params)
  end

  def photo_params
    photo_params = [
      :search_word,
      :address
    ]

    params.fetch(:photo_search).permit(photo_params)
  end
end
