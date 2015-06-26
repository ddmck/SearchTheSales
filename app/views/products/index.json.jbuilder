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

	if @aggs.has_key?("colors")
		json.colors do
			json.array!(@aggs.fetch("colors")) do |color|
				json.id color.fetch("id")
				json.name color.fetch("name")
				json.count color.fetch("count")
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

	if @aggs.has_key?("sub_categories")
		json.subCategories do
			json.array!(@aggs.fetch("sub_categories")) do |sub_category|
				json.id sub_category.fetch("id")
				json.name sub_category.fetch("name")
				json.count sub_category.fetch("count")
			end
		end
	end

	if @aggs.has_key?("styles")
		json.styles do
			json.array!(@aggs.fetch("styles")) do |style|
				json.id style.fetch("id")
				json.name style.fetch("name")
				json.count style.fetch("count")
			end
		end
	end

	if @aggs.has_key?("materials")
		json.materials do
			json.array!(@aggs.fetch("materials")) do |material|
				json.id material.fetch("id")
				json.name material.fetch("name")
				json.count material.fetch("count")
			end
		end
	end
end