class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :body
      
      t.timestamps
    end
    
    add_index :comments, :user_id
    add_index :comments, :post_id
    
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
  end
end
