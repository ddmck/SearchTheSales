class AddMoreIndexesToProduct < ActiveRecord::Migration
  def change
    add_index :products, :url
    add_index :products, :name
  end
end
