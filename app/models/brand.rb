class Brand < ActiveRecord::Base
  validates_presence_of :name, :image_url
  validates_uniqueness_of :name
  has_many :products
  has_many :brand_references
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :featured, -> { where(featured: true)}

end
