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

  def set_category(item)
    categories = Category.all
    cat = nil
    sub_categories = SubCategory.all
    catArray = self.name.downcase.split(" ")
    singularizeOptions = []
    options = []

    categories.each do |category|
      catArray.each do |cat|
        case
        when cat.include?(category.name)
          options << category
        when cat.include?(category.name.singularize)
          singularizeOptions << category
        end
      end
    end

    catch :no_cat_found do
      if options == []
        if singularizeOptions == []
          throw :no_cat_found
        else
          cat = singularizeOptions[0]
        end
      else
        cat = options[0]
      end
    end

    # categories.each do |category|
    #   if self.name.downcase.split(" ").include?(category.name) || 
    #      self.name.downcase.split(" ").include?(category.name.singularize)
    #     cat = category
    #   end 
    # end

    # if cat == nil 
    #   sub_categories.each do |sub_category|
    #     if self.name.downcase.split(" ").include?(sub_category.name) || 
    #        self.name.downcase.split(" ").include?(sub_category.name.singularize)
    #       cat = sub_category.category
    #     end
    #   end
    # end

    if cat.nil? && item[:category]
      categories.each do |category|
        if sanitize_string(item[:category]).downcase.split(" ").include?(category.name) || 
           sanitize_string(item[:category]).downcase.split(" ").include?(category.name.singularize)
          cat = category
        end 
      end
    end

    if cat.nil? && item[:category]
      sub_categories.each do |sub_category|
        if sanitize_string(item[:category]).downcase.split(" ").include?(sub_category.name) || 
           sanitize_string(item[:category]).downcase.split(" ").include?(sub_category.name.singularize)
          cat = sub_category.category
        end 
      end
    end

    self.category = cat
    self.save if self.category 
  end

  # handle_asynchronously :delete_document, :queue => 'indexes'
end
