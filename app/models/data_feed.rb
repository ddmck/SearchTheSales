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
    delete_expired_products
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
    key_hash[color_column.to_sym] = :color if color_column
    key_hash[deeplink_column.to_sym] = :deeplink if deeplink_column
    paths = unzipped_file_path
    paths.each do |path|
      SmarterCSV.process(path,  chunk_size: 500, 
                                key_mapping: key_hash) do |chunk|
        process_chunk(chunk)
      end
    end
    if image_assets
      assets = Object.const_get(image_assets).new
      assets.import
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
  handle_asynchronously :process_chunk, :queue => 'data_feeds'

  def process_item(item)
    product = Product.find_by_large_image_url(item[:large_image_url])
    if product.nil?
      product = Product.new
      product.brand_reference = set_brand_reference(item[:brand])
      product.brand = set_brand(product)
      product.store = set_store
      product.reference_name = set_reference_name(item[:reference_name], product.brand)
      product.name = set_name(product)
      product.description = item[:description]
      product.url = item[:url]
      array_for_matching = create_array_for_matching(item)
      product.color_setter(array_for_matching)
      product.gender_setter(array_for_matching)
      product.category_setter(array_for_matching)
      product.sub_category = set_sub_category(product) if product.category
      product.material_setter(array_for_matching)
      product.style_setter(array_for_matching) if product.category 
    end
    product.image_url = item[:image_url] || item[:large_image_url]
    product.large_image_url = item[:large_image_url] if item[:large_image_url]
    product.deeplink = item[:deeplink] || item[:deeplink]
    product.rrp = sanitize_price(item[:rrp]) if item[:rrp]
    product.sale_price = sanitize_price(item[:sale_price]) if item[:sale_price]
    product.display_price = product.calc_display_price

    if product.size_tags.last && product.size_tags.last.updated_at > 15.minutes.ago
      product.sizes += set_sizes(sanitize_sizes(item[:size])) if item[:size]
    else
      product.sizes = []
      product.sizes = set_sizes(sanitize_sizes(item[:size])) if item[:size]
    end
    product.out_of_stock = false
    product.save if product.changed?
  end

  def create_array_for_matching(item)
    array_for_matching = []
    array_for_matching << item[:category].to_s.downcase.split(" ") if item[:category]
    array_for_matching << item[:reference_name].to_s.downcase.split(" ") if item[:reference_name]
    array_for_matching << item[:description].to_s.downcase.split(" ") if item[:description]

    return array_for_matching
  end

  def delete_expired_products
    key_hash = {}
    key_hash[large_image_url_column.to_sym] = :large_image_url if large_image_url_column
    paths = unzipped_file_path
    result = []
    paths.each do |path|
      result += SmarterCSV.process(path, key_mapping: key_hash)
    end
    result = result.map{ |x| x[:large_image_url] }

    
    store.products.find_in_batches(batch_size: 500) do |current_products|
    
      prod_urls = current_products.map {|p| p.large_image_url}
      to_be_del = prod_urls - result

      to_be_del.each do |p|
        product = Product.find_by_large_image_url(p)
        product.sizes = []
        product.out_of_stock = true
        product.save if product.changed?
      end

    end
  end
end
