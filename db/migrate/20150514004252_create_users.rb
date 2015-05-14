class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :decrypted_password
      t.string :provider
      t.string :uid
      t.string :access_token
      t.string :secret_token

      t.timestamps
    end
  end
end
