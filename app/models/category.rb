class Category < ActiveRecord::Base
  has_many :products
  has_many :sub_categories
  validates_uniqueness_of :name

  before_save :downcase_name

  def downcase_name
    name.downcase!
  end

  def is_female_only
    if female_only
      return true
    else  
      return false
    end
  end
end
