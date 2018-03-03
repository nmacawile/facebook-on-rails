class AddPosterColumnToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :poster_id, :integer
    add_foreign_key :posts, :users, column: :poster_id
    add_index :posts, :poster_id
  end
end
