class AddBannerToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :banner, :string
  end
end
