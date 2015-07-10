json.extract! @recommendation_item, :id, :product_id, :recommendation_id, :description, :index, :liked, :created_at, :updated_at
json.product do
  json.extract! @recommendation_item.product, :id,
                                             :name,
                                             :url,
                                             :image_url,
                                             :display_price,
                                             :store_id,
                                             :sizes,
                                             :brand_name

end
