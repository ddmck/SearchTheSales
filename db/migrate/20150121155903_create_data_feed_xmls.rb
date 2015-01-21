class CreateDataFeedXmls < ActiveRecord::Migration
  def change
    create_table :data_feed_xmls do |t|
      t.text     "feed_url"
      t.integer  "store_id"
      t.string   "name_column"
      t.string   "description_column"
      t.string   "rrp_column"
      t.string   "sale_price_column"
      t.string   "link_column"
      t.string   "image_url_column"
      t.string   "brand_column"
      t.string   "size_column"
      t.string   "color_column"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "last_run_time"
      t.string   "gender_column"
      t.string   "category_column"
      t.string   "large_image_url_column"
    end
    add_index "data_feed_xmls", ["store_id"], name: "index_data_feed_xmls_on_store_id", using: :btree
  end
end
