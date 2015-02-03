class AddImageUrlsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :image_urls, :text
  end
end
