require 'elasticsearch/model'

class Product < ActiveRecord::Base
  include Elasticsearch::Model
  include DataFeedSetter
  extend FriendlyId
  friendly_id :name, use: :slugged

  after_commit on: [:create] do
    index_document
  end

  after_commit on: [:update] do
    update_document
  end

  after_commit on: [:destroy] do
    delete_document
  end

  validates_presence_of :name, :store_id, :url
  validates_uniqueness_of :name, :url
  belongs_to :brand
  belongs_to :brand_reference
  belongs_to :store
  belongs_to :category
  belongs_to :sub_category
  belongs_to :style
  belongs_to :gender
  belongs_to :color
  belongs_to :material
  has_many :order_items
  has_many :basket_items
  has_many :wishlist_items
  has_many :users, through: :wishlist_items
  has_many :size_tags, :dependent => :destroy
  has_many :sizes, through: :size_tags
  has_many :trend_tags, :dependent => :destroy
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
      style_id: style_id,
      gender_id: gender_id,
      color_id: color_id,
      material_id: material_id,
      url: url,
      image_url: image_url,
      first_letter: name.try(:ord) || 0,
      out_of_stock: out_of_stock,
      has_sizes: has_sizes?,
      on_sale: on_sale?
    }
  end

  def on_sale?
    if sale_price && rrp
      sale_price < rrp
    else 
      false
    end
  end

  def has_sizes?
    !sizes.empty? || !!deeplink
  end

  def build_where_hash(filters)
    new_hash = {}
    filters.each_pair do |k, v|
      new_hash[(k + "_id").to_sym] = v
    end
    new_hash
  end

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

  def pretty_brand_name
    brand_name.titleize
  end

  def calc_display_price
    sale_price || rrp
  end

  def set_brand_ref
    brand_reference_id = brand.brand_references.first.id
    save
  end

  handle_asynchronously :set_brand_ref, :queue => 'data_feeds'

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

  def category_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    categories = Category.all
    sub_categories = SubCategory.all
    points = []
    match_array.each do |matcher|
      categories.each do |cat|
        if matcher.include?(cat.name)
          points << cat
        end
      end
      sub_categories.each do |sub_cat|
        if matcher.include?(sub_cat.name)
          points << sub_cat.category
        end
      end
    end
    self.category = order_by_occurance(points)
  end

  def style_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    styles = self.category.styles
    sub_categories = SubCategory.all
    points = []
    match_array.each do |matcher|
      styles.each do |style|
        style.pseudonyms.each do |pseudo|
          if matcher.include?(pseudo)
            points << style
          end
        end
      end
    end
    self.style = order_by_occurance(points)
  end

  def gender_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    mens_matches = ["m", "men", "mens", "men's", "male", "males", "male's", "boys", "boy's"]
    womens_matches = ["f", "women", "womens", "women's", "female", "females", "female's", "girls", "girl's", "ladies"]
    unisex_matches = ["unisex", "uni-sex"]
    points = []

    match_array.each do |matcher|
      matcher.each do |m|
        womens_matches.each do |womens|
          if m.to_s.downcase == womens
            points << "female"
          end
        end
        mens_matches.each do |mens|
          if m.to_s.downcase == mens
            points << "male"
          end
        end
        unisex_matches.each do |unisex|
          if m.to_s.downcase == unisex
            points << "unisex"
          end
        end
      end
    end
    self.gender = Gender.find_by_name(order_by_occurance(points))
  end

  def color_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    colors = Color.all
    points = []
    match_array.each do |matcher|
      colors.each do |color|
        if matcher.include?(color.name)
          points << color
        end
      end
    end
    self.color = order_by_occurance(points)
  end

  def material_setter(match_array=[])
    match_array = [self.name, self.description] if match_array == []

    materials = Material.all
    points = []
    match_array.each do |matcher|
      materials.each do |material|
        if matcher.include?(material.name)
          points << material
        end
      end
    end
    self.material = order_by_occurance(points)
  end

  def order_by_occurance(points)
    return points.group_by{|i| i}.max{|x,y| x[1].length <=> y[1].length}[0] if points != []
  end
end
