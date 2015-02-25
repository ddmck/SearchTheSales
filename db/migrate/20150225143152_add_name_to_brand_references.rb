class AddNameToBrandReferences < ActiveRecord::Migration
  def change
    add_column :brand_references, :name, :string
  end
end
