module Aggregations
	def build_aggs_result(hash)
		if hash
	    brands = build_from_aggs(hash[:brands][:buckets], Brand) if hash[:brands]
	    colors = build_from_aggs(hash[:colors][:buckets], Color) if hash[:colors]
	    categories = build_from_aggs(hash[:categories][:buckets], Category) if hash[:categories]
	    sub_categories = build_from_aggs(hash[:subCategories][:buckets], SubCategory) if hash[:subCategories]
	    styles = build_from_aggs(hash[:styles][:buckets], Style) if hash[:styles]
	    materials = build_from_aggs(hash[:materials][:buckets], Material) if hash[:materials]
	    return {"brands" => brands, "colors" => colors, "categories" => categories, "sub_categories" => sub_categories, "styles" => styles, "materials" => materials}
	  end
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
	    terms: { field: "brand_id", size: 23 }
	  },
	  colors: {
	    terms: { field: "color_id", size: 23 }
	  },
	  categories: {
	    terms: { field: "category_id", size: 23 }
	  },
	  subCategories: {
	    terms: { field: "sub_category_id" }
	  },
	  styles: {
	    terms: { field: "style_id", size: 23 }
	  },
	  materials: {
	    terms: { field: "material_id", size: 23 }
	  }}
  end

  def no_search_aggs(where_opts)
	{
	  query: {
		    filtered: {
		        filter: { and: where_opts }
		    }
	  },
	  aggs: {
	    brands: {
	      terms: { field: "brand_id", size: 23 }
	    },
	    colors: {
	      terms: { field: "color_id", size: 23 }
	    },
	    categories: {
	      terms: { field: "category_id", size: 23 }
	    },
	    subCategories: {
	      terms: { field: "sub_category_id" }
	    },
	    styles: {
	      terms: { field: "style_id", size: 23 }
	    },
	    materials: {
	      terms: { field: "material_id", size: 23 }
	    }
	  }
	}
  end
end