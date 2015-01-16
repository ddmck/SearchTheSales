class AddLargeImageUrlToProduct < ActiveRecord::Migration
  def change
    add_column :products, :large_img_url, :string
  end
end
