class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :user, index: true
      t.integer :sender_id
      t.references :product, index: true
      t.text :description
      t.string :title

      t.timestamps
    end
  end
end
