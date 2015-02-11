class AddImageAssetsToDataFeeds < ActiveRecord::Migration
  def change
    add_column :data_feeds, :image_assets, :string
  end
end
