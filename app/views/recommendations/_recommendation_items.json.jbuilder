json.array!(recommendation_items) do |recommendation_item|
    json.extract! recommendation_item, :id, :product_id, :liked, :description
end
