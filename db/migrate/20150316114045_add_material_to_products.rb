class AddMaterialToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :material, index: true
  end
end
