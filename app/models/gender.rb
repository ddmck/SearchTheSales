class Gender < ActiveRecord::Base
  has_many :products
  has_many :users
end
