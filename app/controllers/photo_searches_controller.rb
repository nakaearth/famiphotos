# frozen_string_literal: true
class PhotoSearchesController < ApplicationController
  def create
    search_service = Photos::Search.new(Photo, photo_search_params)
    search_service.search

    @photos            = search_service.result_record
    @tags_aggregations = search_service.aggregations
  end

  private

  def photo_search_params
    photo_params = [
      :keyword
    ]

    params.fetch(:photo_search).permit(photo_params).merge({ user_id: current_user.id })
  end
end
