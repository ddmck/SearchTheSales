json.array!(@materials) do |material|
  json.extract! material, :id, :name
end