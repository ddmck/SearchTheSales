class Store < ActiveRecord::Base
  validates_presence_of :name, :url, :image_url
  validates_uniqueness_of :name, :url
  has_many :products
end
