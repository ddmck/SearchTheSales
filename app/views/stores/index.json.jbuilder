json.array!(@stores) do |store|
  json.extract! store, :id, :name, :url, :affiliate_code, :image_url
  json.url store_url(store, format: :json)
end
