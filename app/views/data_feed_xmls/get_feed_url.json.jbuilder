json.array!(@data_feeds) do |data_feeds|
  json.extract! data_feeds, :file, :host, :user_name, :password, :store_name
end
