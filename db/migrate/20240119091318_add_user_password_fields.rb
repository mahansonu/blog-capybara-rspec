class AddUserPasswordFields < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_salt, :string
    add_column :users, :password_hash, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
