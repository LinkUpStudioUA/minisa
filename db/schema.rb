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

ActiveRecord::Schema.define(version: 2019_07_22_074904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupons", force: :cascade do |t|
    t.string "promo_code", null: false
    t.float "discount_percentage", null: false
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_answers", force: :cascade do |t|
    t.bigint "service_request_id"
    t.text "text"
    t.text "video_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_request_id"], name: "index_service_answers_on_service_request_id"
  end

  create_table "service_requests", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "buyer_id"
    t.text "text"
    t.text "video_data"
    t.string "status", default: "unsubmitted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coupon_id"
    t.index ["buyer_id"], name: "index_service_requests_on_buyer_id"
    t.index ["coupon_id"], name: "index_service_requests_on_coupon_id"
    t.index ["service_id"], name: "index_service_requests_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "seller_id"
    t.string "title", null: false
    t.text "description"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_services_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "password_digest", null: false
    t.string "email", null: false
    t.string "role", null: false
    t.string "name", null: false
    t.string "location"
    t.text "avatar_data"
    t.float "commission_percentage"
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
