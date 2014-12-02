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

ActiveRecord::Schema.define(version: 20141202111119) do

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
  end

  add_index "data_feeds", ["store_id"], name: "index_data_feeds_on_store_id", using: :btree

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
    t.decimal  "rrp",            precision: 10, scale: 2
    t.decimal  "sale_price",     precision: 10, scale: 2
    t.integer  "category_id"
    t.integer  "gender_id"
    t.string   "reference_name"
  end

  add_index "products", ["brand_id", "store_id"], name: "index_products_on_brand_id_and_store_id", using: :btree
  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["gender_id"], name: "index_products_on_gender_id", using: :btree

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

  create_table "sub_category_tags", force: true do |t|
    t.integer  "sub_category_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_category_tags", ["product_id"], name: "index_sub_category_tags_on_product_id", using: :btree
  add_index "sub_category_tags", ["sub_category_id"], name: "index_sub_category_tags_on_sub_category_id", using: :btree

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
    t.string   "username",               default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "locked",                 default: false, null: false
    t.string   "slug"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "wishlist_items", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wishlist_items", ["product_id"], name: "index_wishlist_items_on_product_id", using: :btree
  add_index "wishlist_items", ["user_id"], name: "index_wishlist_items_on_user_id", using: :btree

end
