class RemoveIndexToProductGender < ActiveRecord::Migration
  def change
    remove_index :products, [:gender]
  end
end
