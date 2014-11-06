class SubCategory < ActiveRecord::Base
  before_save :downcase_name
  validates_uniqueness_of :name
  belongs_to :category
  has_many :sub_category_tags
  has_many :products, through: :sub_category_tags

  def downcase_name
    name.downcase!
  end
end
