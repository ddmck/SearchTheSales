class AddFeatureCatToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :featured_categories, :string
  end
end
