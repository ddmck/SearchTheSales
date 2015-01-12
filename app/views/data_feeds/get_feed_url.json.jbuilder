json.array!(@data_feeds) do |data_feeds|
  json.extract! data_feeds, :feed_url, :store_name
end