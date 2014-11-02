class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :brand_id
      t.integer :store_id
      t.string :url
      t.string :image_url
      t.text :description
      t.string :gender

      t.timestamps
    end
  end
end
