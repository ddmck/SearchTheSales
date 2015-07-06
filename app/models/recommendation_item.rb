class RecommendationItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :recommendation

  def to_builder
    Jbuilder.new do |recommendation_item|
      recommendation_item.product product.to_builder
      recommendation_item.description description
    end
  end

end
