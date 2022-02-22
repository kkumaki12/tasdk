class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string, unique: true, null: false
    add_index :users, :email
    add_column :users, :password_digest, :string, null: false
  end
end
