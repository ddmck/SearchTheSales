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
    paths = unzipped_file_path
    paths.each do |path|
      SmarterCSV.process(path,  chunk_size: 1000, 
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
    sbefore = product.sizes.to_a
    product.sizes = set_sizes(sanitize_sizes(item[:size])) if item[:size]
    schanged = (sbefore != product.sizes.to_a)
    product.save if product.changed? || schanged
  end


  def delete_expired_products
    key_hash = {}
    key_hash[link_column.to_sym] = :url if link_column
    paths = unzipped_file_path
    result = []
    paths.each do |path|
      result += SmarterCSV.process(path, key_mapping: key_hash)
    end
    result = result.map{ |x| x[:url] }
    current_products = store.products
    prod_urls = current_products.map {|p| p.url}
    to_be_del = prod_urls - result

    to_be_del.each do |p|
      product = Product.find_by_url(p)
      sbefore = product.sizes.to_a
      product.sizes = []
      schanged = (sbefore != product.sizes.to_a)
      product.save if schanged
    end
  end
end
