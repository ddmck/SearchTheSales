class SubCategoryTag < ActiveRecord::Base
  belongs_to :sub_category
  belongs_to :product
end
