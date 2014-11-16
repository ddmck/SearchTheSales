json.array!(@products) do |product|
  json.extract! product, :id, :name, :brand_id, :store_id, :url, :image_url, :description, :gender, :sale_price, :rrp
  json.api_url product_url(product, format: :json)
  json.brand_name product.brand.name.titleize
end
