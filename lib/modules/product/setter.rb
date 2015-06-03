module Product::Setter
  def category_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    categories = Category.all
    sub_categories = SubCategory.all
    points = []
    match_array.each do |matcher|
      categories.each do |cat|
        if matcher.to_s.downcase.include?(cat.name)
          points << cat
        end
      end
      sub_categories.each do |sub_cat|
        if matcher.to_s.downcase.include?(sub_cat.name)
          points << sub_cat.category
        end
      end
    end
    self.category = order_by_occurance(points)
  end

  def style_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    styles = self.category.styles
    sub_categories = SubCategory.all
    points = []
    match_array.each do |matcher|
      styles.each do |style|
        style.pseudonyms.each do |pseudo|
          if matcher.to_s.downcase.include?(pseudo)
            points << style
          end
        end
      end
    end
    self.style = order_by_occurance(points)
  end

  def gender_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    mens_matches = ["m", "men", "mens", "men's", "male", "males", "male's", "boys", "boy's"]
    womens_matches = ["f", "women", "womens", "women's", "female", "females", "female's", "girls", "girl's", "ladies"]
    unisex_matches = ["unisex", "uni-sex"]
    points = []

    match_array.each do |matcher|
      matcher.split.each do |m|
        womens_matches.each do |womens|
          if m.to_s.downcase == womens
            points << "female"
          end
        end
        mens_matches.each do |mens|
          if m.to_s.downcase == mens
            points << "male"
          end
        end
        unisex_matches.each do |unisex|
          if m.to_s.downcase == unisex
            points << "unisex"
          end
        end
      end
    end
    self.gender = Gender.find_by_name(order_by_occurance(points))
  end

  def color_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    colors = Color.all
    points = []
    match_array.each do |matcher|
      colors.each do |color|
        if matcher.to_s.downcase.include?(color.name)
          points << color
        end
      end
    end
    self.color = order_by_occurance(points)
  end

  def material_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    materials = Material.all
    points = []
    match_array.each do |matcher|
      materials.each do |material|
        if matcher.to_s.downcase.include?(material.name)
          points << material
        end
      end
    end
    self.material = order_by_occurance(points)
  end

  def order_by_occurance(points)
    return points.group_by{|i| i}.max{|x,y| x[1].length <=> y[1].length}[0] if points != []
  end
end