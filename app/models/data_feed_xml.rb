require 'nokogiri'
require 'net/ftp'

class DataFeedXml < ActiveRecord::Base
  validates_presence_of :file
  belongs_to :store

  def self.update_all
    self.all.each { |df| df.process_file }
  end

  def ftp_client
    Net::FTP.open(host) do |ftp|
      ftp.login(username, password)
      ftp.get(file + '.gz')
    end
  end

  def uncompress_gz
    Zlib::GzipReader.open(file + ".gz") do |gz|
      File.open(file, "w") do |g|
        IO.copy_stream(gz, g)
      end
    end
  end

  def get_doc
    Nokogiri::XML(File.open(""))
  end

  def style_canon(word)
    word.capitalize
  end

  def sanitize(word)
    word.to_s.gsub(/\<.\w+\>/, "")
  end

  def sanitize_url(url)
    url.to_s.gsub(/&amp;/, "&")
  end

  def extract_category_arrays(array, path)
    doc = get_doc
    doc.xpath(path).each do |xml|
        array << xml
    end
    array
  end

  def sanitize_cat(category)
    category.gsub(/[^\w\s\&]/, " ")
  end

  def extract_category(hash, primary, secondary)
    primary = extract_category_arrays(primary, "//product//primary")
    secondary = extract_category_arrays(secondary, "//product//secondary")
    source = []
    primary.each_with_index do |pri, i|
      source[i] = "#{pri} #{secondary[i]}"
    end
    source.each_with_index do |src, i|

      hash[i]["category_column"] = sanitize_cat(sanitize(sanitize(source[i])))
    end
  end

  def extract_xml(path, hash, col_name)
    doc = get_doc

    doc.xpath(path).each_with_index do |xml, i|
      hash[i][col_name] = style_canon(sanitize(sanitize(xml)))
    end
    hash
  end

  def extract_xml_attr(path, attribute, hash, col_name)
    temp_arr = []
    doc = get_doc

    doc.xpath("//product").each do |a|
      temp_arr << a.attr(attribute)
    end

    temp_arr = temp_arr.compact!

    temp_arr.each_with_index do |a, i|
      hash[i][col_name] = a.to_s
    end
    hash
  end

  def extract_xml_url(path, hash, col_name)
    doc = get_doc

    doc.xpath(path).each_with_index do |xml, i|
      hash[i][col_name] = sanitize_url(sanitize(sanitize(xml)))
    end
    hash
  end

  def process_file
    hash = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
    primary = []
    secondary = []
    ftp_client()
    uncompress_gz(file)


    extract_xml_attr("//product", "name", hash, "name_column")

    extract_xml_url("//product//product", hash, "link_column")

    extract_xml("//product//brand", hash, "brand_column")
    extract_xml("//product//productImage", hash, "img_url_column")
    extract_xml("//product//sale", hash, "sales_price_column")
    extract_xml("//product//retail", hash, "rrp_price_column")
    extract_xml("//product//short", hash, "description_column")
    extract_xml("//product//Gender", hash, "gender_column")
    extract_category(hash, primary, secondary)
    extract_xml("//product//Size", hash, "size_column")
    hash
  end
end
