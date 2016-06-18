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

ActiveRecord::Schema.define(version: 20160618093113) do

  create_table "activities", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "receiver",      limit: 255
    t.string   "phone",         limit: 255
    t.string   "address",       limit: 255
    t.string   "city_name",     limit: 255
    t.string   "province_name", limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "consumer_id",   limit: 4
    t.boolean  "is_default",    limit: 1,   default: false, null: false
    t.boolean  "deleted",       limit: 1,   default: false, null: false
    t.integer  "province_id",   limit: 4
    t.integer  "city_id",       limit: 4
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "role",                   limit: 255
    t.integer  "customer_id",            limit: 4
    t.string   "name",                   limit: 255
  end

  create_table "advertisements", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "link",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "text",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id", limit: 4
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "attachable_type",    limit: 255
    t.integer  "attachable_id",      limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",               limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "display",    limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "province_id",    limit: 4
    t.integer  "display_weight", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumers", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "authentication_token",   limit: 255
    t.string   "user_name",              limit: 255
    t.string   "phone",                  limit: 255
    t.string   "provider",               limit: 255
    t.string   "openid",                 limit: 255
    t.string   "nickname",               limit: 255
    t.integer  "sex",                    limit: 4
    t.string   "city",                   limit: 255
    t.string   "province",               limit: 255
    t.string   "headimgurl",             limit: 255
    t.string   "refresh_token",          limit: 255
  end

  add_index "consumers", ["authentication_token"], name: "index_consumers_on_authentication_token", length: {"authentication_token"=>191}, using: :btree

  create_table "create_spaces", force: :cascade do |t|
    t.text     "introduction", limit: 65535
    t.text     "policy",       limit: 65535
    t.text     "support",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "phone",       limit: 255
  end

  create_table "educations", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "free_shipment_coupons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "min_price",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title",   limit: 255
    t.text   "text",    limit: 65535
    t.string "company", limit: 255
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.integer  "product_id",        limit: 4
    t.integer  "quantity",          limit: 4
    t.float    "unit_price",        limit: 24
    t.string   "state",             limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "handle_state",      limit: 255, default: "未处理", null: false
    t.string   "logistical",        limit: 255
    t.string   "logistical_number", limit: 255
    t.integer  "sku_id",            limit: 4
  end

  create_table "news", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "consumer_id",         limit: 4
    t.integer  "address_id",          limit: 4
    t.string   "state",               limit: 255
    t.float    "total_price",         limit: 24
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.float    "ship_fee",            limit: 24
    t.string   "sn",                  limit: 255
    t.string   "logistical",          limit: 255
    t.string   "logistical_number",   limit: 255
    t.string   "handle_state",        limit: 255,   default: "未处理", null: false
    t.boolean  "deleted",             limit: 1,     default: false, null: false
    t.text     "comment",             limit: 65535
    t.string   "invoice_title",       limit: 255
    t.integer  "payment_method_id",   limit: 4
    t.string   "payment_method_name", limit: 255
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                        limit: 255
    t.string   "image_url",                   limit: 255
    t.string   "description",                 limit: 255
    t.string   "price",                       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link",                        limit: 255
    t.boolean  "hot",                         limit: 1
    t.string   "product_detail_file_name",    limit: 255
    t.string   "product_detail_content_type", limit: 255
    t.integer  "product_detail_file_size",    limit: 4
    t.datetime "product_detail_updated_at"
    t.string   "service_file_name",           limit: 255
    t.string   "service_content_type",        limit: 255
    t.integer  "service_file_size",           limit: 4
    t.datetime "service_updated_at"
    t.integer  "customer_id",                 limit: 4
    t.string   "unit",                        limit: 255
    t.integer  "stock_number",                limit: 4
    t.boolean  "free_ship",                   limit: 1,   default: false,    null: false
    t.boolean  "on_sale",                     limit: 1,   default: false,    null: false
    t.integer  "display_order",               limit: 4,   default: 0,        null: false
    t.string   "cash_on_delivery",            limit: 255, default: "支持货到付款", null: false
    t.integer  "sold_number",                 limit: 4,   default: 0,        null: false
  end

  create_table "products_tags", id: false, force: :cascade do |t|
    t.integer "tag_id",     limit: 4, null: false
    t.integer "product_id", limit: 4, null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "pro_remark",     limit: 255
    t.integer  "display_weight", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rich_rich_files", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name",    limit: 255
    t.string   "rich_file_content_type", limit: 255
    t.integer  "rich_file_file_size",    limit: 4
    t.datetime "rich_file_updated_at"
    t.string   "owner_type",             limit: 255
    t.integer  "owner_id",               limit: 4
    t.text     "uri_cache",              limit: 65535
    t.string   "simplified_type",        limit: 255,   default: "file"
  end

  create_table "road_shows", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "text",       limit: 65535
    t.string   "video_link", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipment_fees", force: :cascade do |t|
    t.integer  "province_id",      limit: 4
    t.integer  "city_id",          limit: 4
    t.string   "destination_name", limit: 255
    t.float    "price",            limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "skus", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "price",      limit: 24
    t.integer  "product_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tag_categories", force: :cascade do |t|
    t.string   "display",        limit: 255
    t.string   "name",           limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "present_tag_id", limit: 4
  end

  create_table "tags", force: :cascade do |t|
    t.string   "display",         limit: 255
    t.string   "name",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tag_category_id", limit: 4
  end

  create_table "tourism_tags", force: :cascade do |t|
    t.string   "display",    limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tourism_tags_tourisms", id: false, force: :cascade do |t|
    t.integer "tourism_tag_id", limit: 4, null: false
    t.integer "tourism_id",     limit: 4, null: false
  end

  create_table "tourisms", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.text     "content",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "pingpp_id",        limit: 255
    t.string   "status",           limit: 255
    t.string   "transaction_type", limit: 255
    t.float    "amount",           limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "order_sn",         limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "authentication_token",   limit: 255
    t.string   "role",                   limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", length: {"authentication_token"=>191}, using: :btree

  create_table "virtual_tourisms", force: :cascade do |t|
    t.string   "title",                   limit: 255
    t.string   "description",             limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "video_file_name",         limit: 255
    t.string   "video_content_type",      limit: 255
    t.integer  "video_file_size",         limit: 4
    t.datetime "video_updated_at"
    t.string   "video_url",               limit: 255
    t.string   "thumb_nail_file_name",    limit: 255
    t.string   "thumb_nail_content_type", limit: 255
    t.integer  "thumb_nail_file_size",    limit: 4
    t.datetime "thumb_nail_updated_at"
  end

end
