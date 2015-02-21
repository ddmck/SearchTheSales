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
  has_many :order_items
  has_many :basket_items
  has_many :wishlist_items
  has_many :users, through: :wishlist_items
  has_many :color_tags
  has_many :colors, through: :color_tags
  has_many :size_tags
  has_many :sizes, through: :size_tags
  
  has_many :trend_tags
  has_many :trends, through: :trend_tags

  serialize :image_urls

  def as_indexed_json(options={})
    {
      id: id,
      name: name,
      reference_name: reference_name,
      display_price: display_price.to_f,
      brand_id: brand_id,
      store_id: store_id,
      category_id: category_id,
      sub_category_id: sub_category_id,
      gender_id: gender_id,
      url: url,
      image_url: image_url,
      first_letter: name.try(:ord) || 0,
      out_of_stock: sizes.empty?
    }
  end

  def add_to_wishlist(user)
    puts "User: #{user}"
    puts "Id: #{id}"
    puts "self: #{self}"
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

  def pretty_brand_name
    brand.name.titleize
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
