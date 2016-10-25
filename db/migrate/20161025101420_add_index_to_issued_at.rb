class AddIndexToIssuedAt < ActiveRecord::Migration
  def change
    add_index :authentication_data, :issued_at
  end
end
