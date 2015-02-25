class IndexProductsOnBrandReferenceId < ActiveRecord::Migration
  def change
    add_column :products, :brand_reference_id, :integer
    add_index :products, [:brand_reference_id], name: "index_products_on_brand_reference_id", using: :btree
  end
end
