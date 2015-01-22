class ChangeFeedUrlInDataFeedXml < ActiveRecord::Migration
  def change
    add_column :data_feed_xmls, :file, :text
    remove_column :data_feed_xmls, :feed_url, :text
  end
end
