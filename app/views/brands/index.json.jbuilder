json.array!(@brands) do |brand|
  json.extract! brand, :id, :name, :feature_text, :image_url, :slug, :featured_categories
  json.displayName brand.name
end
