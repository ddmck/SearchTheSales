require 'zip'

class DataFeed < ActiveRecord::Base
  validates_presence_of :feed_url
  belongs_to :store

  def download_feed
    HTTParty.get(feed_url).body
  end

  def feed_temp_file_path
    file = Tempfile.new("feed_file")
    file.binmode
    file.write(download_feed)
    file.close
    file.path
  end

  def unzipped_file_path
    paths = []
    Zip::File.open(feed_temp_file_path) do |file|
      file.each do |entry|
        unzipped_file = Tempfile.new("gfile")
        unzipped_file.binmode
        unzipped_file.write(file.read(entry))
        unzipped_file.close
        paths << unzipped_file.path
      end
    end
    paths
  end

  def process_file
    key_hash = {} 
    key_hash[name_column.to_sym] = :reference_name if name_column 
    key_hash[brand_column.to_sym] = :brand if brand_column
    key_hash[rrp_column.to_sym] = :rrp if rrp_column
    key_hash[sale_price_column.to_sym] = :sale_price if sale_price_column
    key_hash[description_column.to_sym] = :description if description_column
    key_hash[image_url_column.to_sym] = :image_url if image_url_column
    key_hash[link_column.to_sym] = :url if link_column
    key_hash[gender_column.to_sym] = :gender if gender_column
    key_hash[category_column.to_sym] = :category if category_column
    puts "key hash #{key_hash}"
    paths = unzipped_file_path
    paths.each do |path|
      SmarterCSV.process(path,  chunk_size: 100, 
                                key_mapping: key_hash) do |chunk|
        process_chunk(chunk)
      end
    end
    self.last_run_time = Time.now
    self.save
  end
  handle_asynchronously :process_file

  def process_chunk(chunk)
    chunk.each do |item|
      process_item(item)
    end
  end

  def process_item(item)

    if item[:reference_name].nil? || item[:image_url].nil? || item[:url].nil? || !detect_valid_url(item[:url])
      puts "####### NOT VALID MISSING IMPORTANT COLUMN!!!! ######"
      return
    else
      product = Product.find_by_url(item[:url])
      if product.nil?
        product = Product.new
      end

      product.brand = set_brand(item[:brand])
      product.store = set_store
      product.reference_name = set_reference_name(item[:reference_name], product.brand)
      product.name = set_name(product)
      product.description = item[:description]
      product.rrp = sanitize_price(item[:rrp]) if item[:rrp]
      product.sale_price = sanitize_price(item[:sale_price]) if item[:sale_price]
      product.url = item[:url]
      product.image_url = item[:image_url]
      product.gender = set_gender(item)
      product.category = set_category(item, product)
      product.sub_category = set_sub_category(product) if product.category
      product.colors = set_colors(item)
      product.save
    end
  end

  def set_product(identifier)
    product = Product.find_by_reference_name(identifier)
    if product.nil?
      product.new(reference_name: identifier)
    end
    product
  end

  def set_store
    Store.find(store_id)
  end

  def set_brand(identifier)
    brand = Brand.find_by_name(identifier.downcase)
    if brand.nil?
      brand = Brand.create(name: identifier.downcase, image_url: "#");
    end
    brand
  end

  def set_category(item, product)
    categories = Category.all
    cat = nil
    sub_categories = SubCategory.all
      
    if item[:category]
      categories.each do |category|
        if item[:category].downcase.include?(category.name) || 
           item[:category].downcase.include?(category.name.singularize)
          cat = category
        end 
      end
    end

    if cat.nil? && item[:category]
      sub_categories.each do |sub_category|
        if item[:category].downcase.include?(sub_category.name) || 
           item[:category].downcase.include?(sub_category.name.singularize)
          cat = category
        end 
      end
    end
    
    if cat == nil 
      categories.each do |category|
        if product.name.downcase.include?(category.name) || 
           product.name.downcase.include?(category.name.singularize)
          cat = category
        end 
      end
    end

    if cat == nil 
      sub_categories.each do |sub_category|
        if product.name.downcase.include?(sub_category.name) || 
           product.name.downcase.include?(sub_category.name.singularize)
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
    description = sanitize_string(product.description).downcase.remove(product.brand.name).split(" ") if product.description
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

  def set_colors(item)
    clrs = []
    name = sanitize_string(item[:reference_name]).downcase.split(" ")
    description = sanitize_string(item[:description]).downcase.split(" ") if item[:description]
    colors = Color.all
    colors.each do |color|
      if name.include?(color.name) || 
         name.include?(color.name.singularize)
        clrs << color
      end 
      if item[:description]
        if description.include?(color.name) ||
           description.include?(color.name.singularize)
          clrs << color
        end
      end
    end
    clrs 
  end

  def sanitize_string(string)
    string.gsub(/[^\p{Alnum}\p{Space}]/u, '')
  end

  def sanitize_price(price)
    if price.class == String
      price.gsub(/[^\d\.]/, '').to_f
    else
      price.to_f
    end
  end

  def set_name(product)
    product.reference_name.downcase.remove(product.brand.name.downcase).squeeze(" ").gsub("`", "'")
  end

  def set_reference_name(reference_name, brand)
    if reference_name.downcase.include?(brand.name.downcase)
      reference_name.downcase.gsub("`", "'")
    else 
      brand.name.downcase + " " + reference_name.downcase.gsub("`", "'")
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
    mens_matches = ["men", "mens", "men's", "male", "males", "male's", "boys", "boy's"]
    womens_matches = ["women", "womens", "women's", "female", "females", "female's", "girls", "girl's", "ladies"]
    unisex_matches = ["unisex", "uni-sex"]
    gender_match = nil
    sanitize_string(string.downcase).split(" ").each do |word|
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
