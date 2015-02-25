class BrandReference < ActiveRecord::Base
  validates_uniqueness_of :reference
  belongs_to :brand
end
