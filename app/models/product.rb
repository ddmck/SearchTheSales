require 'elasticsearch/model'

class Product < ActiveRecord::Base
  include Elasticsearch::Model
  after_commit on: [:create] do
    index_document
  end

  after_commit on: [:update] do
    update_document
  end

  after_commit on: [:destroy] do
    delete_document
  end

  validates_presence_of :name, :brand_id, :store_id, :url
  validates_uniqueness_of :name, :url
  belongs_to :brand
  belongs_to :store
  belongs_to :category
  belongs_to :sub_category
  belongs_to :gender
  has_many :basket_items
  has_many :wishlist_items
  has_many :users, through: :wishlist_items
  has_many :color_tags
  has_many :colors, through: :color_tags
  
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

  def brand_name
    brand.name
  end 

  def display_price
    sale_price || rrp
  end

  def index_document
    __elasticsearch__.index_document
  end

  handle_asynchronously :index_document, :queue => 'indexes'

  def update_document
    __elasticsearch__.update_document
  end

  handle_asynchronously :update_document, :queue => 'indexes'

  def delete_document
    __elasticsearch__.delete_document
  end

  handle_asynchronously :delete_document, :queue => 'indexes'
end
