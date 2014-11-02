class Product < ActiveRecord::Base
  validates_presence_of :name, :brand_id, :store_id, :url
  belongs_to :brand
  belongs_to :store
end
