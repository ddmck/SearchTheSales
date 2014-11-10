class ProductImport

  def self.import(data={})

    store = self.set_store(data[:store])
    puts store.attributes
    brand = set_brand(data[:brand])
    puts brand.id
    category = set_category(data[:category])
    puts category.id
    sub_categories = set_sub_categories(data[:sub_categories])

    colors = set_colors(data[:colors])

    product = Product.find_by_name(data[:name])
    puts "Before If"
    if product == nil
      product = Product.create( store_id: store.id,
                                brand_id: brand.id,
                                category_id: category.id,
                                name: data[:name],
                                description: data[:description],
                                url: data[:url],
                                image_url: data[:image_url],
                                rrp: data[:rrp],
                                sale_price: data[:sale_price]
                                )
    else
      product.update_attributes( store_id: store.id,
                                brand_id: brand.id,
                                category_id: category.id,
                                name: data[:name],
                                description: data[:description],
                                url: data[:url],
                                image_url: data[:image_url],
                                rrp: data[:rrp],
                                sale_price: data[:sale_price]
                                )
    end

    new_sub_cats = sub_categories - product.sub_categories
    
    new_sub_cats.each do |nsc|
      product.sub_categories << nsc
    end

    new_colors = colors - product.colors
    new_colors.each do |nc|
      product.colors << nc
    end
    

  end

  def self.set_store(store_data)
    puts store_data
    store = Store.find_by_name(store_data)
    if store == nil 
      store = Store.new(name: store_data, 
                         url: '#', 
                         image_url: '#')
      store.save
    end
    store
  end

  def self.set_brand(brand_data)
    brand = Brand.find_by_name(brand_data)
    if brand == nil
      brand =  Brand.new(name: brand_data,  
                            image_url: '#')
      brand.save
    end
    brand
  end

  def self.set_category(category_data)
    category = Category.find_by_name(category_data)
    unless category == nil 
      category = Category.create(name: category_data)
    end
    category
  end

  def self.set_sub_categories(sub_category_data)
    sub_category_data.map do |sub_cat|
      sub_category = SubCategory.find_by_name(sub_cat)
      if sub_category == nil
        sub_category = SubCategory.create(name: sub_cat,
                         category_id: category.id)
      end
      sub_category
    end
  end

  def self.set_colors(color_data)
    color_data.map do |color|
      color = Color.find_by_name(color)
      if color == nil
        color = Color.create(name: color)
      end
      color
    end
  end

end