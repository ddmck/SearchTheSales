class Size < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :size_tags
  has_many :products, through: :size_tags
end
