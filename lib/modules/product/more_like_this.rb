module Product::MoreLikeThis

  def generate_more_like_this
    hash = build_more_like_this
    puts hash
    products = Product.__elasticsearch__.search(hash).records
    return products
  end
  
  def build_match_must
    hash = {}
    if self.gender_id && self.category_id
      where_opts = {"gender_id" => self.gender_id, "category_id" => self.category_id}
    elsif self.gender_id
      where_opts = {"gender_id" => self.gender_id}
    elsif self.category_id
      where_opts = {"category_id" => self.category_id}
    end
    
    where_opts = where_opts.map {|key, v| {match: {key.to_sym => v}}}
    hash = where_opts
    hash
  end

  def build_match_should
    hash = {}

    if self.color_id && self.brand_id
      where_opts = {"color_id" => self.color_id, "brand_id" => self.brand_id}
    elsif self.color_id
      where_opts = {"color_id" => self.color_id}
    elsif self.brand_id
      where_opts = {"brand_id" => self.brand_id}
    end

    where_opts = where_opts.map {|key, v| {match: {key.to_sym => v}}}
    hash = where_opts
    hash
  end

  def build_more_like_this
    hash = {}
    hash = {query: {bool: {
              must: build_match_must,
              should: build_match_should
              }}, size: 25}
    hash
  end
end