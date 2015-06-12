class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :photo
      t.text :description, length: 140
      t.references :user, index: true, null: false
      t.references :group, index: true, null: false

      t.timestamps
    end
  end
end
