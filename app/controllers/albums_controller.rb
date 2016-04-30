class AlbumsController < ApplicationController
  include UserAgent

  before_action :set_request_variant
  before_action :set_album, only: %i( show, edit, destroy )

  def index
    # デフォルトのグループのアルバム
    @albums = @current_group.albums

    # デフォルト以外のグループのアルバム
    @other_group_albums = @current_user.albums_without_this_group(@current_group)

    respond_to do |format|
      format.html
    end
  end

  def show
  end

  def new
    @album = @current_group.albums.build
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

  def set_album
    @album = @current_group.albums.where(id: decrypted_id(params[:album_id])).first
  end

  def album_params
    colums_name = [
      :id,
      albums_attributes: [
        :title
      ]
    ]

    params.require(:group).permit(colums_name)
  end
end
