class DailyPhotosController < ApplicationController
  include UserAgent
  include DecryptedId

  before_action :set_request_variant
  before_action :set_album, only: %i( index )
  before_action :set_date_from_created_at_ymd, only: %i( index )
  before_action :set_photos, only: %i( index )

  def index 
  end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_album
    @album = @current_group.albums.where(id: decrypted_id(params[:album_id])).first
  end

  def set_date_from_created_at_ymd
    @selected_date = Date.strptime(params[:created_at_ymd], '%Y/%m/%d')
  end

  def set_photos
    @photos = @album.photos.where(created_at: @selected_date...@selected_date.next_day).page(params[:page])
  end
end
