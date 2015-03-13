module DataFeedSetter
  def set_store
    Store.find(store_id)
  end

  def set_brand(product)
    product.brand_reference.brand
  end

  def set_brand_reference(identifier)
    brand_ref = BrandReference.find_by_reference(identifier.to_s.downcase)
    if brand_ref.nil?
      brand = Brand.create(name: identifier.to_s)
      brand_ref = BrandReference.create(name: identifier.to_s, reference: identifier.to_s.downcase, brand_id: brand.id)
    end
    brand_ref
  end

  def set_category(item, product)
    categories = Category.all
    cat = nil
    sub_categories = SubCategory.all
    

    categories.each do |category|
      if product.name.downcase.split(" ").include?(category.name) || 
         product.name.downcase.split(" ").include?(category.name.singularize)
        cat = category
      end 
    end

    if cat == nil 
      sub_categories.each do |sub_category|
        if product.name.downcase.split(" ").include?(sub_category.name) || 
           product.name.downcase.split(" ").include?(sub_category.name.singularize)
          cat = sub_category.category
        end
      end
    end

    if cat.nil? && item[:category]
      categories.each do |category|
        if sanitize_string(item[:category]).downcase.split(" ").include?(category.name) || 
           sanitize_string(item[:category]).downcase.split(" ").include?(category.name.singularize)
          cat = category
        end 
      end
    end

    if cat.nil? && item[:category]
      sub_categories.each do |sub_category|
        if sanitize_string(item[:category]).downcase.split(" ").include?(sub_category.name) || 
           sanitize_string(item[:category]).downcase.split(" ").include?(sub_category.name.singularize)
          cat = sub_category.category
        end 
      end
    end
    
    

    # if cat == nil && product.description
    #   categories.each do |category|
    #     if product.description.downcase.remove(product.brand.name).include?(category.name) ||
    #        product.description.downcase.remove(product.brand.name).include?(category.name.singularize)
    #       cat = category
    #     end
    #   end
    # end

    # if cat == nil && product.description
    #   sub_categories.each do |sub_category|
    #     if product.description.downcase.remove(product.brand.name).include?(sub_category.name) ||
    #        product.description.downcase.remove(product.brand.name).include?(sub_category.name.singularize)
    #       cat = sub_category.category
    #     end 
    #   end
    # end
    cat
  end

  def set_sub_category(product)
    sub_cat = nil
    name = sanitize_string(product.name).downcase.split(" ")
    bn = product.brand.try(:name) ? product.brand.try(:name) : ""
    description = sanitize_string(product.description).downcase.remove(bn).split(" ") if product.description
    sub_categories = product.category.sub_categories
    sub_categories.each do |sub_category|
      if name.include?(sub_category.name) || 
         name.include?(sub_category.name.singularize)
        sub_cat = sub_category
      end 
      if sub_cat.nil? && product.description
        if description.include?(sub_category.name) ||
           description.include?(sub_category.name.singularize)
          sub_cat = sub_category
        end
      end 
    end
    sub_cat
  end

  def set_color(item)
    clr = nil
    color_arr = sanitize_string(item[:color]).downcase.split(" ") if item[:color]
    name = sanitize_string(item[:reference_name]).downcase.split(" ")
    colors = Color.all

    if color_arr
      colors.each do |color|
        if color_arr.include?(color.name)
          clr = color
        end
        break if clr
      end
    end

    if clr.nil?
      colors.each do |color|
        if name.include?(color.name)
          clr = color
        end
        break if clr 
      end
    end

    clr
  end

  def sanitize_string(string)
    string.to_s.gsub(/[^\p{Alnum}\p{Space}]/u, '')
  end

  def sanitize_price(price)
    if price.class == String
      if price == ""
        nil
      else
        price.gsub(/[^\d\.]/, '').to_f
      end
    else
      price.to_f
    end
  end

  def sanitize_sizes(string)
    string.to_s.upcase.split(/,|\||\~\~|\~/).map { |s| s.strip }
  end

  def set_sizes(size_list)
    size_list.map do |size|
      set_size = Size.find_by_name(size)
      if set_size.nil?
        set_size = Size.create(name: size)
      end
      set_size
    end
  end

  def set_name(product)
    name = product.brand.try(:name).try(:downcase) ? product.reference_name.downcase.remove(product.brand.try(:name).try(:downcase)).squeeze(" ").gsub("`", "'").strip() : product.reference_name.downcase.squeeze(" ").gsub("`", "'").strip()
    if name[-3 .. -1] == " by"
      name = name[0 .. -4] 
    end
    name
  end

  def set_reference_name(reference_name, brand)
    if brand.try(:name).try(:downcase) && reference_name.downcase.include?(brand.try(:name).try(:downcase))
      reference_name.downcase.gsub("`", "'")
    elsif brand.try(:name).try(:downcase)
      brand.try(:name).try(:downcase) + " " + reference_name.downcase.gsub("`", "'")
    else
      reference_name.downcase.gsub("`", "'")
    end
  end

  def set_gender(item)
    gender = detect_gender(item[:gender]) if item[:gender]
    if gender.nil? && item[:category]
      gender = detect_gender(item[:category])
    end
    if gender.nil? && item[:reference_name]
      gender = detect_gender(item[:reference_name])
    end
    if gender.nil? && item[:description]
      gender = detect_gender(item[:description])
    end
    if gender
      return Gender.find_by_name(gender)
    else
      return nil
    end
  end

  def detect_gender(string)
    mens_matches = ["m", "men", "mens", "men's", "male", "males", "male's", "boys", "boy's"]
    womens_matches = ["f", "women", "womens", "women's", "female", "females", "female's", "girls", "girl's", "ladies"]
    unisex_matches = ["unisex", "uni-sex"]
    gender_match = nil
    sanitize_string(string).downcase.split(" ").each do |word|
      unless gender_match
        if mens_matches.include?(word)
          gender_match = "male"
        elsif womens_matches.include?(word)
          gender_match = "female"
        elsif unisex_matches.include?(word)
          gender_match = "unisex"
        end
      end
    end
    gender_match
  end

  def detect_valid_url(string)
    uri = URI.parse(string)
    %w( http https ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end