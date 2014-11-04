class Product < ActiveRecord::Base
  validates_presence_of :name, :brand_id, :store_id, :url
  belongs_to :brand
  belongs_to :store
  has_many :basket_items
  has_many :wishlist_items
  has_many :users, through: :wishlist_items

  def add_to_wishlist(user)
    WishlistItem.create(product_id: self.id, user_id: user.id)
  end

  def wished_for_by
    users
  end

  def add_to_basket(user)
    user.basket.create_basket_item(self)
  end
end
