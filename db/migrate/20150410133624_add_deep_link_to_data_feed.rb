class AddDeepLinkToDataFeed < ActiveRecord::Migration
  def change
    add_column :data_feeds, :deeplink_column, :text
  end
end
