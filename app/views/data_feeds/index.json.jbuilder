json.array!(@data_feeds) do |data_feed|
  json.extract! data_feed, :id, :feed_url, :store_id, :name_column, :description_column, :rrp_column, :sale_price_column, :link_column, :image_url_column, :brand_column, :size_column, :color_column
  json.url data_feed_url(data_feed, format: :json)
end
