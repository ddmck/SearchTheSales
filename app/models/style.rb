class Style < ActiveRecord::Base
  before_save :downcase_name
  validates_uniqueness_of :name
  belongs_to :category
  has_many :products

  def downcase_name
    name.downcase!
  end

  def contains_space?
    self.name.include?(" ")
  end

  def pseudonyms
    list = [self.name]
    list << self.name.gsub(" ", "-")
    list << self.name.gsub(" ", "")
  end
end
