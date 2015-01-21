require 'zip'

class DataFeed < ActiveRecord::Base
  validates_presence_of :feed_url
  belongs_to :store
  
  def self.update_all
    self.all.each { |df| df.process_file }
  end

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

  def store_name
    self.store.name
  end

  def process_file
    key_hash = {} 
    key_hash[name_column.to_sym] = :reference_name if name_column 
    key_hash[brand_column.to_sym] = :brand if brand_column
    key_hash[rrp_column.to_sym] = :rrp if rrp_column
    key_hash[sale_price_column.to_sym] = :sale_price if sale_price_column
    key_hash[description_column.to_sym] = :description if description_column
    key_hash[image_url_column.to_sym] = :image_url if image_url_column
    key_hash[large_image_url_column.to_sym] = :large_image_url if large_image_url_column
    key_hash[link_column.to_sym] = :url if link_column
    key_hash[gender_column.to_sym] = :gender if gender_column
    key_hash[category_column.to_sym] = :category if category_column
    key_hash[size_column.to_sym] = :size if size_column
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
  handle_asynchronously :process_file, :queue => 'data_feeds'

  def process_chunk(chunk)
    chunk.each do |item|
      process_item(item)
    end
  end

  def process_item(item)

    # if item[:reference_name].nil? || item[:image_url].nil? || item[:url].nil? || item[:brand].nil?
    #   puts "####### NOT VALID MISSING IMPORTANT COLUMN!!!! ######"
    #   puts "DataFeed: #{self.id}, Item: #{item}"
    #   return
    # else
    product = Product.find_by_url(item[:url])
    if product.nil?
      product = Product.new
      product.brand = set_brand(item[:brand])
      product.store = set_store
      product.reference_name = set_reference_name(item[:reference_name], product.brand)
      product.name = set_name(product)
      product.description = item[:description]
      product.url = item[:url]
      product.colors = set_colors(item)
      product.gender = set_gender(item)
      product.category = set_category(item, product)
      product.sub_category = set_sub_category(product) if product.category
    end
    product.image_url = item[:image_url] || item[:large_image_url]
    product.large_image_url = item[:large_image_url] if item[:large_image_url]
    product.rrp = sanitize_price(item[:rrp]) if item[:rrp]
    product.sale_price = sanitize_price(item[:sale_price]) if item[:sale_price]
    product.sizes = set_sizes(sanitize_sizes(item[:size])) if item[:size]
    product.save if product.changed?
    # end
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
    brand = Brand.find_by_name(identifier.to_s.downcase)
    if brand.nil?
      brand = Brand.create(name: identifier.to_s.downcase, image_url: "#");
    end
    brand
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
    string.to_s.gsub(/[^\p{Alnum}\p{Space}]/u, '')
  end

  def sanitize_price(price)
    if price.class == String
      price.gsub(/[^\d\.]/, '').to_f
    else
      price.to_f
    end
  end

  def sanitize_sizes(string)
    string.to_s.upcase.split(/,|\|/).map { |s| s.strip }
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
    name = product.reference_name.downcase.remove(product.brand.name.downcase).squeeze(" ").gsub("`", "'").strip()
    if name[-3 .. -1] == " by"
      name = name[0 .. -4] 
    end
    name
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
