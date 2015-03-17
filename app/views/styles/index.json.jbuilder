json.array!(@styles) do |style|
  json.extract! style, :id, :name, :category_id
end