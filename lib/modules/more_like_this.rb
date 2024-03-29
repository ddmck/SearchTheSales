module MoreLikeThis
  def more_like_this
    hash = build_more_like_this(params["on_sale"])
    @products = Product.__elasticsearch__.search(hash).page(1).records
    respond_with(@products)
  end

  def build_match_must(sale_only)
    if @product.gender_id && @product.category_id
      where_opts = {"gender_id" => @product.gender_id, "category_id" => @product.category_id}
    elsif @product.gender_id
      where_opts = {"gender_id" => @product.gender_id}
    elsif @product.category_id
      where_opts = {"category_id" => @product.category_id}
    end
    where_opts["on_sale"] = sale_only if sale_only
    where_opts.map {|key, v| {match: {key.to_sym => v}}}
  end

  def build_match_should
    if @product.color_id && @product.brand_id
      where_opts = {"color_id" => @product.color_id, "brand_id" => @product.brand_id}
    elsif @product.color_id
      where_opts = {"color_id" => @product.color_id}
    elsif @product.brand_id
      where_opts = {"brand_id" => @product.brand_id}
    end

    where_opts.map {|key, v| {match: {key.to_sym => v}}}
  end

  def build_more_like_this(sale_only=false)
    hash = {query: {bool: {
              must: build_match_must(sale_only),
              should: build_match_should
              }}, size: 25}
    hash
  end
end
