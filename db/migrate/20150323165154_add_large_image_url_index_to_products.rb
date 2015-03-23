class AddLargeImageUrlIndexToProducts < ActiveRecord::Migration
  def change
    add_index :products, :large_image_url
  end
end
