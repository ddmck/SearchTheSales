class Feature < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  belongs_to :sub_category
  belongs_to :gender
  belongs_to :store
end
