class AddReferenceNameToProducts < ActiveRecord::Migration
  def change
    add_column :products, :reference_name, :string
  end
end
