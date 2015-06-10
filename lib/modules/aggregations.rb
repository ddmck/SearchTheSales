module Aggregations
	def build_aggs_result(hash)
    brands = build_from_aggs(hash[:brands][:buckets], Brand)
    categories = build_from_aggs(hash[:categories][:buckets], Category)
    styles = build_from_aggs(hash[:styles][:buckets], Style)
    {"brands" => brands, "categories" => categories, "styles" => styles}
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
	  genders: {
	    terms: { field: "gender_id" }
	  },
	  styles: {
	    terms: { field: "style_id" }
	  },
	  material: {
	    terms: { field: "material_id" }
	  }}
  end
end