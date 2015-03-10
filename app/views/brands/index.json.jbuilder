json.array!(@brands) do |brand|
  json.extract! brand, :id, :name, :feature_text, :image_url, :slug
end
