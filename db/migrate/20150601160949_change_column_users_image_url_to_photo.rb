class ChangeColumnUsersImageUrlToPhoto < ActiveRecord::Migration
  def change
    rename_column :users, :image_url, :photo
  end
end
