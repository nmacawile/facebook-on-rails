class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :liker_id
      t.integer :likeable_id
      t.string :likeable_type, null: false

      t.timestamps
    end
    
    add_index :likes, :liker_id
    add_index :likes, :likeable_type
    add_index :likes, :likeable_id
    add_index :likes, [:likeable_id, :liker_id, :likeable_type], unique: true
    
    add_foreign_key :likes, :users, column: :liker_id
  end
end
