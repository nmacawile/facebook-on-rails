class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :actor_id
      t.integer :receipient_id
      t.string :linkable_type
      t.integer :linkable_id
      t.integer :action

      t.timestamps
    end
    
    add_index :notifications, :receipient_id
    add_foreign_key :notifications, :users, column: :receipient_id
    add_foreign_key :notifications, :users, column: :actor_id
  end
end
