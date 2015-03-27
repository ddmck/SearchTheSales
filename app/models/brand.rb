class Brand < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :products
  has_many :brand_references
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :featured, -> { where(featured: true)}
  serialize :featured_categories

  def self.generate_all
    self.featured.each { |b| b.generate_featured_categories }
  end

  def generate_featured_categories
    products = self.products
    categories = Category.all
    categoriesHash = Hash.new
    categoriesArr = []
    holdingArr = []
    lastHash = Hash.new
    collection = []


    categories.each do |c|
      categoriesHash[c.id] = products.where(category_id: c.id).count
    end

    categoriesArr = categoriesHash.sort_by { |id, count| count }.reverse

    (0..3).each do |count|
      holdingArr << categoriesArr[count][0]
    end

    holdingArr.each do |id|
      lastHash["name"] = Category.find(id).name
      lastHash["id"] = id
      collection.push(lastHash)
      lastHash = Hash.new
    end

    self.featured_categories = collection
    self.save
  end

end
