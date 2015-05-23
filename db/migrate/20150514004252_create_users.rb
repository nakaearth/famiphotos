class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :decrypted_password
      t.string :provider, null: false
      t.string :nickname
      t.string :uid
      t.string :image_url
      t.string :access_token
      t.string :secret_token
      t.references :group, index: true, null: false

      t.timestamps
    end

    add_index :users, [:provider, :email]
  end
end
