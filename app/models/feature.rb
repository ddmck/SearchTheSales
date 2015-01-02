class Feature < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  belongs_to :sub_category
  belongs_to :gender
  belongs_to :store
  has_many :feature_links
  validates_presence_of :title
  validates_presence_of :copy
  extend FriendlyId
  friendly_id :title, use: :slugged

  def build_where_statement
    important_keys = ["brand_id", "store_id", "category_id", "sub_category_id", "gender_id"]
    important_keys.reject! {|k| self[k].nil? }
    attributes.select {|k, v| important_keys.include?(k)}
  end

  def build_search_string
    string = search_string.downcase
    string = string.remove(category.name.singularize) if category_id
    if string.strip == ""
      string = search_string.downcase
    end
    string += ' OR ' + string.downcase + '~' 
    build_where_statement.each do |k,v|
      string += " AND #{k}: #{v}" 
    end
    string
  end

  def build_query_string
    hash = build_where_statement
    hash.delete("brand_id") if brand_id
    hash.delete("store_id") if store_id
    hash["gender_id"] = gender.name if gender_id
    hash["search_string"] = search_string if search_string != ""
    new_hash = {}
    hash.each do |k, v|
      key = k.remove("_id").camelize(:lower)
      new_hash[key] = v
    end
    "?" + new_hash.to_query
  end

  def products
    if search_string.empty?
      Product.where(build_where_statement).first(100)
    else
      found_products = Product.__elasticsearch__.search(query: {
                                                query_string: {
                                                  default_field: "reference_name",
                                                  query: build_search_string
                                                }}, size: 25)
      array = found_products.page(1).records
      array += found_products.page(2).records
      array += found_products.page(3).records
      array += found_products.page(4).records
    end
  end
end
