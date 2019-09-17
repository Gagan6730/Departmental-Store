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

ActiveRecord::Schema.define(version: 20181029143249) do

  create_table "catalog_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "qty"
    t.decimal  "price"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "catalog_items", ["category_id"], name: "index_catalog_items_on_category_id"
  add_index "catalog_items", ["user_id"], name: "index_catalog_items_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id"

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "catalog_item_id"
    t.integer "quantity"
  end

  add_index "order_items", ["catalog_item_id"], name: "index_order_items_on_catalog_item_id"
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "user_id"
    t.decimal "total"
    t.string  "date"
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id"

  create_table "stores", force: :cascade do |t|
    t.string   "shopName"
    t.string   "registrationNumber"
    t.string   "locality"
    t.string   "city"
    t.integer  "pin"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "stores", ["user_id"], name: "index_stores_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "password"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
