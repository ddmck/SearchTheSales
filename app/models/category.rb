class Category < ActiveRecord::Base
  has_many :products

  before_save :downcase_name

  def downcase_name
    name.downcase!
  end
end
