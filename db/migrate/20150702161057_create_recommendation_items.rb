class CreateRecommendationItems < ActiveRecord::Migration
  def change
    create_table :recommendation_items do |t|
      t.references :product, index: true
      t.references :recommendation, index: true
      t.text :description
      t.integer :index
      t.boolean :liked

      t.timestamps
    end
  end
end
