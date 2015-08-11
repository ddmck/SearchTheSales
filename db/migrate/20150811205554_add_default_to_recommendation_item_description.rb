class AddDefaultToRecommendationItemDescription < ActiveRecord::Migration
  def change
    change_column :recommendation_items, :description, :text, :default => ""
  end
end
