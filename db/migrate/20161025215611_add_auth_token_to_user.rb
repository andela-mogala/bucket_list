class AddAuthTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :text
    add_index :users, :auth_token
  end
end
