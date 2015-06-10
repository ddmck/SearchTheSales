json.array!(@recommendations) do |recommendation|
  json.extract! recommendation, :id, :user_id, :sender_id, :product_id, :description, :title
  json.url recommendation_url(recommendation, format: :json)
end
