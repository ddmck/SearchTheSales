json.array!(@recommendations) do |recommendation|
  json.extract! recommendation, :id, :user_id, :sender_id, :sender_name, :title
  json.recommendation_items recommendation.recommendation_items do |recommendation_item|
    json.extract! recommendation_item, :id, :description, :liked
    json.product do
      json.extract! recommendation_item.product, :id,
                                                 :name,
                                                 :url,
                                                 :image_url,
                                                 :display_price,
                                                 :store_id,
                                                 :sizes,
                                                 :brand_name

    end
  end
end
