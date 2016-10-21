class CreateBucketlists < ActiveRecord::Migration
  def change
    create_table :bucketlists do |t|
      t.string :name
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :bucketlists, :name
    add_index :bucketlists, :user_id
  end
end
