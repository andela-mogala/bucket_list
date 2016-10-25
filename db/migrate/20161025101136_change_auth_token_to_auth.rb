class ChangeAuthTokenToAuth < ActiveRecord::Migration
  def change
    rename_column :authentication_data, :auth_token, :token
  end
end
