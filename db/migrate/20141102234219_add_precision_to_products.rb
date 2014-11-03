class AddPrecisionToProducts < ActiveRecord::Migration
  def change
    change_column :products, :rrp, :decimal, precision: 10, scale: 2
    change_column :products, :sale_price, :decimal, precision: 10, scale: 2
  end
end
