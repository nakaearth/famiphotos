class GroupsController < ApplicationController
  include UserAgent
  include DecryptedId

  before_action :set_request_variant
  before_action :set_group, only: [:edit, :show, :destroy]

  def index
    respond_to do |format|
      @groups = @current_user.my_groups.page(params[:page])

      format.html
    end
  end

  def show
    render partial: 'show', format: :html
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if Group.with_writable { @group.save_with_group_member(@current_user, group_params[:group_member][:role]) }
      redirect_to groups_path, notice: 'グループを作成しました'
    else
      render action: :new, alert: 'グループ作成に失敗しました'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @group.destroy

    redirect_to groups_path, notice: 'グループを削除しました'
  end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_group
    @group = Group.find(decrypted_id(params[:id]))
  end

  def group_params
    colums_name = [
      :name,
      group_member: [
        :role
      ]
    ]

    params.require(:group).permit(colums_name)
  end
end
