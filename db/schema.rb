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

ActiveRecord::Schema.define(version: 20150404202123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.hstore   "cart"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "listing_id"
  end

  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listing_categories", force: :cascade do |t|
    t.integer "listing_id"
    t.integer "category_id"
  end

  add_index "listing_categories", ["category_id"], name: "index_listing_categories_on_category_id", using: :btree
  add_index "listing_categories", ["listing_id"], name: "index_listing_categories_on_listing_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.boolean  "private_bathroom",                           default: true
    t.decimal  "price",              precision: 6, scale: 2
    t.integer  "quantity_available"
    t.integer  "people_per_unit"
    t.hstore   "available_dates"
    t.integer  "user_id"
    t.integer  "status",                                     default: 0
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "username"
    t.text     "password_digest"
    t.text     "email_address"
    t.text     "display_name"
    t.integer  "role",            default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "avatar"
    t.string   "credit_card"
    t.string   "billing_address"
  end

end
