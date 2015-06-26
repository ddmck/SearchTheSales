json.array!(@materials) do |material|
  json.extract! material, :id, :name
  json.displayName material.name
end