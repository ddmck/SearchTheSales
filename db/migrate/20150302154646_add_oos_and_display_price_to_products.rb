class AddOosAndDisplayPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :out_of_stock, :boolean, :default => false
    add_column :products, :display_price, :decimal
  end
end
