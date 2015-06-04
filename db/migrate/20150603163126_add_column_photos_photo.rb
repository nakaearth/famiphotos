class AddColumnPhotosPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :photo, :string, null: false
  end
end
