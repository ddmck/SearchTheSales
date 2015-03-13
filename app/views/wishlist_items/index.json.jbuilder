json.array!(@wishlist_items) do |wl|
  json.extract! wl, :id
  json.product wl.product_json
end