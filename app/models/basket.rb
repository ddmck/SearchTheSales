class Basket < ActiveRecord::Base
  belongs_to :user
  has_many :basket_items
  
end
