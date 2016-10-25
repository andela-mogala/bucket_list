class CreateAuthenticationData < ActiveRecord::Migration
  def change
    create_table :authentication_data do |t|
      t.references :user, index: true, foreign_key: true
      t.text :auth_token
      t.datetime :issued_at

      t.timestamps null: false
    end
  end
end
