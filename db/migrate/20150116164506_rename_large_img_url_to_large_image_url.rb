class RenameLargeImgUrlToLargeImageUrl < ActiveRecord::Migration
  def change
    rename_column :products, :large_img_url, :large_image_url
  end
end
