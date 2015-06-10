if @products
  json.array!(@products) do |product|
    json.extract! product, :id, :name, :store_id, :brand_id, :url, :image_url, :display_price, :rrp, :brand_name, :slug
  end
end