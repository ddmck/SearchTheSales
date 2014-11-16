class AddIndexToProductOnBrandAndStoreId < ActiveRecord::Migration
  def change
    add_index :products, [:brand_id, :store_id]
  end
end
