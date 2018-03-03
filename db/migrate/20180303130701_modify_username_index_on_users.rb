class ModifyUsernameIndexOnUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :username
    add_index :users,
              'lower(username)',
               unique: true
  end
end
