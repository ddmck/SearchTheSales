class AddSearchthesalesToUser < ActiveRecord::Migration
  def change
    add_column :users, :search_the_sales, :boolean
  end
end
