require 'zip'

class DataFeed < ActiveRecord::Base
  include DataFeedSetter
  validates_presence_of :feed_url
  belongs_to :store
  
  def self.update_all
    self.where(active: true).each { |df| df.process_file }
  end

  def store_name
    self.store.name
  end

  ### Concerning Downloading Files

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

  ### concerning CSV

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
    delete_expired_products

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


  def delete_expired_products

    paths = unzipped_file_path

    result = {}
    products_hash = {}
    expired_products = {}

    paths.each do |path|
      CSV.foreach(path) do |row|
        result[row[3]] = [row[0]]
      end
    end

     store = store_id
     current_products = Product.all.where("store_id = #{store}")

     current_products.each do |p|
       products_hash["#{p.url}"] = p.name
     end

    products_hash.each_key do |e|
      if(!result.has_key?(e))
        expired_products[e] = products_hash.fetch(e)
      end
    end

    expired_products.each_key do |key|
      product = Product.find_by_url(key)
      product.sizes = []
      product.save
    end
  end
end
