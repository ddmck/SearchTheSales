class Feature < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  belongs_to :sub_category
  belongs_to :gender
  belongs_to :store
  has_many :feature_links
  validates_presence_of :title
  validates_presence_of :copy

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

  def products
    if search_string
      Product.__elasticsearch__.search(query: {
                                                query_string: {
                                                  default_field: "reference_name",
                                                  query: build_search_string
                                                }}, size: 52).page(1).records
    else
      Product.where(build_where_statement).first(52)
    end
  end
end
