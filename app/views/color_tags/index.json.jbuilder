json.array!(@color_tags) do |color_tag|
  json.extract! color_tag, :id, :color_id, :product_id
  json.url color_tag_url(color_tag, format: :json)
end
