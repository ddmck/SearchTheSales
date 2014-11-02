class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.text :feature_text
      t.string :image_url

      t.timestamps
    end
  end
end
