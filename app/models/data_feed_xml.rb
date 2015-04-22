require 'nokogiri'
require 'net/ftp'

class DataFeedXml < ActiveRecord::Base
  include DataFeedSetter
  validates_presence_of :file
  belongs_to :store

  def self.update_all
    self.all.each { |df| df.process_file }
  end

  def ftp_client
    Net::FTP.open(host) do |ftp|
      ftp.passive = true
      ftp.login(user_name, password)
      ftp.get(file, "./tmp/#{file}")
    end
  end

  def uncompress_gz
    Zlib::GzipReader.open("./tmp/#{file}") do |gz|
      File.open("./tmp/#{file}"[0 .. -4], "w") do |g|
        IO.copy_stream(gz, g)
      end
    end
  end

  def get_doc
    Nokogiri::XML(File.open("./tmp/#{file}"[0 .. -4]))
  end

  def sanitize(word)
    word.to_s.gsub(/\<.\w+\>/, "")
  end

  def sanitize_url(url)
    url.to_s.gsub(/&amp;/, "&")
  end

  def sanitize_cat(category)
    category.gsub(/[^\w\s\&]/, " ")
  end

  def extract_xml(path, product)
    sanitize(sanitize(product.css(path)))
  end

  def extract_xml_attr(attribute, product)
    product.attr(attribute)
  end

  def extract_xml_url(path, product)
    sanitize_url(sanitize(sanitize(product.css(path))))
  end

  def build_xml_array
    # Skip product urls being included
    get_doc.css("product[name]")
  end

  def process_file
    ftp_client
    uncompress_gz

    delete_expired_products

    products = build_xml_array

    products.each do |product|
      result = {}
      result[:reference_name] = extract_xml_attr(name_column, product)
      result[:url] = extract_xml_url(link_column, product)
      result[:brand] = extract_xml(brand_column, product)
      result[:image_url] = extract_xml_url(image_url_column, product)
      result[:large_image_url] = extract_xml_url(image_url_column, product)
      result[:sale_price] = extract_xml(sale_price_column, product)
      result[:rrp] = extract_xml(rrp_column, product)
      result[:description] = extract_xml(description_column, product)
      result[:gender] = extract_xml(gender_column, product)
      result[:category] = extract_xml(category_column, product)
      result[:size] = extract_xml(size_column, product)
      result[:color] = extract_xml(color_column, product)
      process_line(result)
    end
    if image_assets
      assets = Object.const_get(image_assets).new
      assets.import
    end
  end
  handle_asynchronously :process_file, :queue => 'data_feeds'

  def process_line(item)
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
      product.color = set_color(item)
      product.gender = set_gender(item)
      product.category = set_category(item, product)
      product.sub_category = set_sub_category(product) if product.category
    end
    product.material = set_material(product)
    product.style = set_style(product) if product.category
    product.image_url = item[:image_url] || item[:large_image_url]
    product.large_image_url = item[:large_image_url] if item[:large_image_url]
    product.rrp = sanitize_price(item[:rrp]) if item[:rrp]
    product.sale_price = sanitize_price(item[:sale_price]) if item[:sale_price]
    product.display_price = product.calc_display_price
    if product.size_tags.last && product.size_tags.last.updated_at > 15.minutes.ago
      product.sizes += set_sizes(sanitize_sizes(item[:size])) if item[:size]
    else
      product.sizes = []
      product.sizes = set_sizes(sanitize_sizes(item[:size])) if item[:size]
    end
    product.out_of_stock = product.sizes.empty?
    product.save if product.changed?
  end

  def delete_expired_products

    key_hash = {}
    key_hash[large_image_url_column.to_sym] = :large_image_url if large_image_url_column
    result = []
    products = build_xml_array

    products.each do |prod|
      result << extract_xml_url(large_image_url_column, prod)
    end
    
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
