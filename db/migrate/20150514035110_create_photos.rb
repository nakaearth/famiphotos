class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :description, length: 140
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.references :user, index: true, null: false
      t.references :group, index: true, null: false

      t.timestamps
    end
  end
end
