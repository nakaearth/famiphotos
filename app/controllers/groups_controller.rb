class GroupsController < ApplicationController
  include UserAgent

  before_action :set_request_variant

  def index
    @groups = @current_user.my_groups

    respond_to do |format|
      format.html
    end
  end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end
end

