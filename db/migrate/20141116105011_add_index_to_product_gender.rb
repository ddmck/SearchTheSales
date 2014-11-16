class AddIndexToProductGender < ActiveRecord::Migration
  def change
    add_index :products, [:gender]
  end
end
