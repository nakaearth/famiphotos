class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.text :message
      t.string :title

      t.timestamps
    end
  end
end
