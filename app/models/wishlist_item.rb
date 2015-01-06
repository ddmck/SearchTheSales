class WishlistItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :product_id, uniqueness: { scope: :user_id }
end
