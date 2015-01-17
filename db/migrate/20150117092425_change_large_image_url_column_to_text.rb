class ChangeLargeImageUrlColumnToText < ActiveRecord::Migration
  def change
    change_column :products, :large_image_url, :text
  end
end
