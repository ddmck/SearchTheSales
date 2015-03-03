class AddFeaturedToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :featured, :boolean
  end
end
