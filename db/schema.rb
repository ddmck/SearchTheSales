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

ActiveRecord::Schema.define(version: 20150820003742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "provider",                              null: false
    t.string   "uid",                    default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
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
    t.boolean  "admin",                  default: true
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["uid", "provider"], name: "index_admins_on_uid_and_provider", unique: true, using: :btree

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

  create_table "brand_references", force: true do |t|
    t.string   "reference"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "brand_references", ["brand_id"], name: "index_brand_references_on_brand_id", using: :btree

  create_table "brands", force: true do |t|
    t.string   "name"
    t.text     "feature_text"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured"
    t.text     "slug"
    t.string   "featured_categories"
  end

  add_index "brands", ["slug"], name: "index_brands_on_slug", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "female_only"
  end

  create_table "colors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured"
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
    t.string   "image_assets"
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
    t.boolean  "active"
    t.string   "image_assets"
    t.text     "deeplink_column"
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

  create_table "materials", force: true do |t|
    t.string   "name"
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "text"
    t.integer  "sender_id"
    t.integer  "user_id"
    t.datetime "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "size_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size_name"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree
  add_index "order_items", ["size_id"], name: "index_order_items_on_size_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

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
    t.decimal  "rrp",                precision: 10, scale: 2
    t.decimal  "sale_price",         precision: 10, scale: 2
    t.integer  "category_id"
    t.integer  "gender_id"
    t.string   "reference_name"
    t.integer  "sub_category_id"
    t.text     "large_image_url"
    t.text     "image_urls"
    t.integer  "brand_reference_id"
    t.boolean  "out_of_stock",                                default: false
    t.decimal  "display_price"
    t.integer  "color_id"
    t.text     "slug"
    t.integer  "material_id"
    t.integer  "style_id"
    t.text     "deeplink"
  end

  add_index "products", ["brand_id", "store_id"], name: "index_products_on_brand_id_and_store_id", using: :btree
  add_index "products", ["brand_reference_id"], name: "index_products_on_brand_reference_id", using: :btree
  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["color_id"], name: "index_products_on_color_id", using: :btree
  add_index "products", ["gender_id"], name: "index_products_on_gender_id", using: :btree
  add_index "products", ["image_url"], name: "index_products_on_image_url", using: :btree
  add_index "products", ["large_image_url"], name: "index_products_on_large_image_url", using: :btree
  add_index "products", ["material_id"], name: "index_products_on_material_id", using: :btree
  add_index "products", ["name"], name: "index_products_on_name", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree
  add_index "products", ["style_id"], name: "index_products_on_style_id", using: :btree
  add_index "products", ["sub_category_id"], name: "index_products_on_sub_category_id", using: :btree
  add_index "products", ["url"], name: "index_products_on_url", using: :btree

  create_table "recommendation_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "recommendation_id"
    t.text     "description",       default: ""
    t.integer  "index"
    t.boolean  "liked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendation_items", ["product_id"], name: "index_recommendation_items_on_product_id", using: :btree
  add_index "recommendation_items", ["recommendation_id"], name: "index_recommendation_items_on_recommendation_id", using: :btree

  create_table "recommendations", force: true do |t|
    t.integer  "user_id"
    t.integer  "sender_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendations", ["user_id"], name: "index_recommendations_on_user_id", using: :btree

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

  add_index "sizes", ["name"], name: "index_sizes_on_name", using: :btree

  create_table "stores", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "affiliate_code"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "standard_price"
    t.decimal  "express_price"
    t.decimal  "free_delivery_threshold"
    t.text     "delivery_copy"
    t.integer  "days_to_return"
    t.text     "returns_copy"
    t.boolean  "ub",                      default: false
  end

  create_table "styles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "styles", ["category_id"], name: "index_styles_on_category_id", using: :btree

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
    t.string   "stripe_customer_id"
    t.string   "password_reset_token"
    t.boolean  "search_the_sales"
    t.boolean  "fetch_my_fashion"
    t.integer  "admin_id"
    t.string   "push_token"
    t.text     "quiz_results"
    t.integer  "gender_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["gender_id"], name: "index_users_on_gender_id", using: :btree
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
