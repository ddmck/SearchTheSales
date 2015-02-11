class AddImageAssetsToDataFeedXmls < ActiveRecord::Migration
  def change
    add_column :data_feed_xmls, :image_assets, :string
  end
end
