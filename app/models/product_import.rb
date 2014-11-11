class ProductImport
  def self.import_chunk(chunk)
    chunk.each do |data|
      import(data)
    end
  end

  def self.import(data = {})
    store = set_store(data['store'])
    brand = set_brand(data['brand'])
    category = set_category(data['category'])
    sub_categories = set_sub_categories(data['sub_categories'], category)
    colors = set_colors(data['colors'])
    product = Product.find_by_name(data['name'])

    if product.nil?
      product = Product.create(store_id: store.id,
                               brand_id: brand.id,
                               category_id: category.id,
                               name: data['name'],
                               description: data[:"description"],
                               url: data['url'],
                               image_url: data['image_url'],
                               rrp: data['rrp'],
                               sale_price: data['sale_price'],
                               gender: data['gender']
                                )
    else
      product.update_attributes(store_id: store.id,
                                brand_id: brand.id,
                                category_id: category.id,
                                name: data['name'],
                                description: data[:"description"],
                                url: data['url'],
                                image_url: data['image_url'],
                                rrp: data['rrp'],
                                sale_price: data['sale_price'],
                                gender: data['gender']
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
    store = Store.find_by_name(store_data.try(:downcase))
    if store.nil?
      store = Store.new(name: store_data,
                        url: '#',
                        image_url: '#')
      store.save
    end
    store
  end

  def self.set_brand(brand_data)
    brand = Brand.find_by_name(brand_data.try(:downcase))
    if brand.nil?
      brand = Brand.new(name: brand_data.try(:downcase),
                        image_url: '#')
      brand.save
    end
    brand
  end

  def self.set_category(category_data)
    category = Category.find_by_name(category_data.try(:downcase))
    if category.nil?
      category = Category.new(name: category_data.try(:downcase))
      category.save
    end
    category
  end

  def self.set_sub_categories(sub_category_data, category)
    sub_category_data.map! do |sub_cat|
      sub_category = SubCategory.find_by_name(sub_cat.try(:downcase))
      if sub_category.nil?
        sub_category = SubCategory.create(name: sub_cat.try(:downcase),
                                          category_id: category.id)
      end
      sub_category
    end
  end

  def self.set_colors(color_data)
    color_data.map do |c|
      color = Color.find_by_name(c.try(:downcase))
      if color.nil?
        color = Color.create(name: c.try(:downcase))
      end
      color
    end
  end
end
