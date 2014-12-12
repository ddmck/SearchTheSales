class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :copy
      t.references :brand, index: true
      t.references :category, index: true
      t.references :sub_category, index: true
      t.string :search_string
      t.references :gender, index: true
      t.references :store, index: true
      t.string :image_url

      t.timestamps
    end
  end
end
