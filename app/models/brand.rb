class Brand < ActiveRecord::Base
  validates_presence_of :name, :image_url
  validates_uniqueness_of :name
end
