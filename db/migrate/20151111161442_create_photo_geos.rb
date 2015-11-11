class CreatePhotoGeos < ActiveRecord::Migration
  def change
    create_table :photo_geos do |t|
      t.integer :photo_id
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps null: false
    end

    create_index :photo_geos, [photo_id], unique: :true
  end
end
