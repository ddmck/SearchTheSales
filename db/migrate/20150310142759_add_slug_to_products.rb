class AddSlugToProducts < ActiveRecord::Migration
  def change
    add_column :products, :slug, :text
    add_index :products, :slug, unique: true
  end
end
