class AddLargeImageUrlColumnToDataFeeds < ActiveRecord::Migration
  def change
    add_column :data_feeds, :large_image_url_column, :string
  end
end
