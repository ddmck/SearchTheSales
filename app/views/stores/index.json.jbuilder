json.array!(@stores) do |store|
  json.extract! store, :id, :name, :affiliate_code, :image_url, :delivery_copy, :returns_copy, :days_to_return
  json.standard_price store.standard_price.to_f
  json.express_price store.express_price.to_f 
  json.free_delivery_threshold store.free_delivery_threshold.to_f
end
