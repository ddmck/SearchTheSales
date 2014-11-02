class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :url
      t.string :affiliate_code
      t.string :image_url

      t.timestamps
    end
  end
end
