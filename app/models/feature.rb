class Feature < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  belongs_to :sub_category
  belongs_to :gender
  belongs_to :store
  validates_presence_of :title
  validates_presence_of :copy

  def build_where_statement
    important_keys = ["brand_id", "store_id", "category_id", "sub_category_id", "gender_id"]
    important_keys.reject! {|k| self[k].nil? }
    attributes.select {|k, v| important_keys.include?(k)}
  end
end
