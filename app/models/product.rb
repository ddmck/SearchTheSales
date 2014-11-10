class Product < ActiveRecord::Base
  validates_presence_of :name, :brand_id, :store_id, :url
  belongs_to :brand
  belongs_to :store
  belongs_to :category
  has_many :basket_items
  has_many :wishlist_items
  has_many :users, through: :wishlist_items
  has_many :color_tags
  has_many :colors, through: :color_tags
  has_many :sub_category_tags
  has_many :sub_categories, through: :sub_category_tags
  has_many :trend_tags
  has_many :trends, through: :trend_tags

  def add_to_wishlist(user)
    WishlistItem.create(product_id: id, user_id: user.id)
  end

  def wished_for_by
    users
  end

  def add_to_basket(user)
    user.basket.create_basket_item(self)
  end
end
