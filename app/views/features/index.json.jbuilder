json.array!(@features) do |feature|
  json.extract! feature, :id, :title, :copy, :brand_id, :category_id, :sub_category_id, :search_string, :gender_id, :store_id, :image_url
  json.url feature_url(feature, format: :json)
end
