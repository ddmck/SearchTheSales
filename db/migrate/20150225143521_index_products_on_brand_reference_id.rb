class IndexProductsOnBrandReferenceId < ActiveRecord::Migration
  def change
    add_column :products, :brand_reference_id, :integer
    add_index :products, [:brand_reference_id]
  end
end
