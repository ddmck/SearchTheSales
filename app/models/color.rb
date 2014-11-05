class Color < ActiveRecord::Base
  before_save :downcase_name
  has_many :products, through: :color_tags
  validates_uniqueness_of :name

  def downcase_name
    name.downcase!
  end
end
