json.array!(@trends) do |trend|
  json.extract! trend, :id, :name
  json.url trend_url(trend, format: :json)
end
