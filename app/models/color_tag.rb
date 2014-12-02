class ColorTag < ActiveRecord::Base
  belongs_to :color
  belongs_to :product
  validates_uniqueness_of :color_id, :scope => [:product_id]
end
