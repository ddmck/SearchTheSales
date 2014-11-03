class AddSalePriceAndRrpToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rrp, :decimal
    add_column :products, :sale_price, :decimal
  end
end
