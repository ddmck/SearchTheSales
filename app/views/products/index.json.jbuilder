if @products
	json.products do
		json.array!(@products) do |product|
		  json.extract! product, :id, :name, :store_id, :brand_id, :url, :image_url, :display_price, :rrp, :brand_name, :slug
		end
	end
end

if @aggs
	if @aggs.has_key?("brands")
		json.brands do
			json.array!(@aggs.fetch("brands")) do |brand|
				json.id brand.fetch("id")
				json.name brand.fetch("name")
				json.count brand.fetch("count")
			end
		end
	end

	if @aggs.has_key?("categories")
		json.categories do
			json.array!(@aggs.fetch("categories")) do |category|
				json.id category.fetch("id")
				json.name category.fetch("name")
				json.count category.fetch("count")
			end
		end
	end
end