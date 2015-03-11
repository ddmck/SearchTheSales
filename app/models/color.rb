class Color < ActiveRecord::Base
  before_save :downcase_name
  has_many :products
  validates_uniqueness_of :name

  scope :featured, -> { where(featured: true)}

  def downcase_name
    name.downcase!
  end
end
