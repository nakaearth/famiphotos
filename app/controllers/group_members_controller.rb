# frozen_string_literal: true
class GroupMembersController < ApplicationController
  def index
    @users = current_group.users
  end

  def show; end

  def new
    @group = current_user.build_group
  end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def group_member_params; end
end
