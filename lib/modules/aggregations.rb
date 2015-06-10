module Aggregations
	def build_aggs_result(hash)
    brands = build_from_aggs(hash[:brands][:buckets], Brand) if hash[:brands]
    colors = build_from_aggs(hash[:colors][:buckets], Color) if hash[:colors]
    categories = build_from_aggs(hash[:categories][:buckets], Category) if hash[:categories]
    sub_categories = build_from_aggs(hash[:subCategories][:buckets], SubCategory) if hash[:subCategories]
    styles = build_from_aggs(hash[:styles][:buckets], Style) if hash[:styles]
    materials = build_from_aggs(hash[:materials][:buckets], Material) if hash[:materials]
    {"brands" => brands, "colors" => colors, "categories" => categories, "sub_categories" => sub_categories, "styles" => styles, "materials" => materials}
  end

  def build_from_aggs(items, klass)
    array = []
    items.each do |item|
      b = klass.find(item[:key])
      array << {"id" => b.id, "count" => item[:doc_count], "name" => b.name}
    end
    array
  end

  def build_aggs
	  {brands: {
	    terms: { field: "brand_id" }
	  },
	  colors: {
	    terms: { field: "color_id" }
	  },
	  categories: {
	    terms: { field: "category_id" }
	  },
	  subCategories: {
	    terms: { field: "sub_category_id" }
	  },
	  styles: {
	    terms: { field: "style_id" }
	  },
	  materials: {
	    terms: { field: "material_id" }
	  }}
  end
end