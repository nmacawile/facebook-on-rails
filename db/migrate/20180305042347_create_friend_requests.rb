class CreateFriendRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_requests do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end
    
    add_foreign_key :friend_requests, :users
    add_foreign_key :friend_requests, :users, column: :friend_id
    add_index :friend_requests, :user_id
    add_index :friend_requests, :friend_id
    add_index :friend_requests, [:user_id, :friend_id]
  end
end
