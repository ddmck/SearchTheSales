class SubCategory < ActiveRecord::Base
  before_save :downcase_name
  validates_uniqueness_of :name
  belongs_to :category
  has_many :products

  def downcase_name
    name.downcase!
  end
end
