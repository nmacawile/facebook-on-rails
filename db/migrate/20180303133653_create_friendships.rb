class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end
    
    add_index :friendships, :user_id
    add_index :friendships, :friend_id
    add_index :friendships, [:user_id, :friend_id], unique: true
    add_foreign_key :friendships, :users
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
