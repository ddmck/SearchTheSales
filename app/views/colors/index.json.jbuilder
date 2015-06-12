json.array!(@colors) do |color|
  json.extract! color, :id, :name
  json.url color_url(color, format: :json)
  json.displayName color.name
end
