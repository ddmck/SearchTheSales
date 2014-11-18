json.array!(@products) do |product|
  json.extract! product, :id, :name, :brand_id, :store_id, :url, :image_url, :description, :gender_id, :sale_price, :rrp
end
