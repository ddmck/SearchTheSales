json.array!(@recommendation_items) do |recommendation_item|
  json.extract! recommendation_item, :id, :product_id, :recommendation_id, :description, :index, :liked
  json.url recommendation_item_url(recommendation_item, format: :json)
end
