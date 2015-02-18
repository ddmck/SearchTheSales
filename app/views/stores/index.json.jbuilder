json.array!(@stores) do |store|
  json.extract! store, :id, :name, :affiliate_code, :image_url, :standard_price, :express_price, :free_delivery_threshold, :delivery_copy, :returns_copy, :days_to_return
end
