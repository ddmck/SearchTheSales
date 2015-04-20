class AddFetchmyfashionToUser < ActiveRecord::Migration
  def change
    add_column :users, :fetch_my_fashion, :boolean
  end
end
