class AlbumsController < ApplicationController
  include UserAgent

  before_action :set_request_variant

  def index
    @albums = @current_group.albums

    respond_to do |format|
      format.html
    end
  end

  def show
  end

  def close
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

#  def photo_params
#    # TODO: nested_attributを使う
#    colums_name = [
#      :description,
#      :image,
#      photo_geo_attributes: [
#        :address
#      ]
#    ]
#
#    params.require(:photo).permit(colums_name)
#  end
end
