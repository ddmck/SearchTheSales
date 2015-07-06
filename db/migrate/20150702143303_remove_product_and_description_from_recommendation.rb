class RemoveProductAndDescriptionFromRecommendation < ActiveRecord::Migration
  def change
    remove_column :recommendations, :product_id
    remove_column :recommendations, :description
  end
end
