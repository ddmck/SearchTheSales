# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150122151533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basket_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "basket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "basket_items", ["basket_id"], name: "index_basket_items_on_basket_id", using: :btree
  add_index "basket_items", ["product_id"], name: "index_basket_items_on_product_id", using: :btree

  create_table "baskets", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "baskets", ["user_id"], name: "index_baskets_on_user_id", using: :btree

  create_table "brands", force: true do |t|
    t.string   "name"
    t.text     "feature_text"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "color_tags", force: true do |t|
    t.integer  "color_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "color_tags", ["color_id"], name: "index_color_tags_on_color_id", using: :btree
  add_index "color_tags", ["product_id"], name: "index_color_tags_on_product_id", using: :btree

  create_table "colors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_feed_xmls", force: true do |t|
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
    t.text     "file"
    t.string   "host"
    t.string   "user_name"
    t.string   "password"
  end

  add_index "data_feed_xmls", ["store_id"], name: "index_data_feed_xmls_on_store_id", using: :btree

  create_table "data_feeds", force: true do |t|
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

  add_index "data_feeds", ["store_id"], name: "index_data_feeds_on_store_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "feature_links", force: true do |t|
    t.string   "name"
    t.string   "link_url"
    t.integer  "feature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feature_links", ["feature_id"], name: "index_feature_links_on_feature_id", using: :btree

  create_table "features", force: true do |t|
    t.string   "title"
    t.text     "copy"
    t.integer  "brand_id"
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.string   "search_string"
    t.integer  "gender_id"
    t.integer  "store_id"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "features", ["brand_id"], name: "index_features_on_brand_id", using: :btree
  add_index "features", ["category_id"], name: "index_features_on_category_id", using: :btree
  add_index "features", ["gender_id"], name: "index_features_on_gender_id", using: :btree
  add_index "features", ["slug"], name: "index_features_on_slug", unique: true, using: :btree
  add_index "features", ["store_id"], name: "index_features_on_store_id", using: :btree
  add_index "features", ["sub_category_id"], name: "index_features_on_sub_category_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "genders", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content_md"
    t.text     "content_html"
    t.boolean  "draft",        default: false
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.integer  "store_id"
    t.text     "url"
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "rrp",             precision: 10, scale: 2
    t.decimal  "sale_price",      precision: 10, scale: 2
    t.integer  "category_id"
    t.integer  "gender_id"
    t.string   "reference_name"
    t.integer  "sub_category_id"
    t.text     "large_image_url"
  end

  add_index "products", ["brand_id", "store_id"], name: "index_products_on_brand_id_and_store_id", using: :btree
  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["gender_id"], name: "index_products_on_gender_id", using: :btree
  add_index "products", ["sub_category_id"], name: "index_products_on_sub_category_id", using: :btree

  create_table "size_tags", force: true do |t|
    t.integer  "product_id"
    t.integer  "size_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "size_tags", ["product_id"], name: "index_size_tags_on_product_id", using: :btree
  add_index "size_tags", ["size_id"], name: "index_size_tags_on_size_id", using: :btree

  create_table "sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "affiliate_code"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "sub_categories", ["category_id"], name: "index_sub_categories_on_category_id", using: :btree

  create_table "trend_tags", force: true do |t|
    t.integer  "product_id"
    t.integer  "trend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trend_tags", ["product_id"], name: "index_trend_tags_on_product_id", using: :btree
  add_index "trend_tags", ["trend_id"], name: "index_trend_tags_on_trend_id", using: :btree

  create_table "trends", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider",                            null: false
    t.string   "uid",                    default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "wishlist_items", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wishlist_items", ["product_id"], name: "index_wishlist_items_on_product_id", using: :btree
  add_index "wishlist_items", ["user_id"], name: "index_wishlist_items_on_user_id", using: :btree

end
