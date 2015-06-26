json.array!(@categories) do |category|
  json.extract! category, :id, :name, :is_female_only
  json.displayName category.name
end
