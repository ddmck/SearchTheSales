class Trend < ActiveRecord::Base
  has_many :trend_tags
  has_many :products, through: :trend_tags
  before_save :downcase_name

  def downcase_name
    name.downcase!
  end
end
