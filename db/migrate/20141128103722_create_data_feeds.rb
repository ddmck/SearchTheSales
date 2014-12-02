class CreateDataFeeds < ActiveRecord::Migration
  def change
    create_table :data_feeds do |t|
      t.text :feed_url
      t.references :store, index: true
      t.string :name_column
      t.string :description_column
      t.string :rrp_colomn
      t.string :sale_price_column
      t.string :link_column
      t.string :image_url_coloum
      t.string :brand_column
      t.string :size_column
      t.string :color_column

      t.timestamps
    end
  end
end
