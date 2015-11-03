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

ActiveRecord::Schema.define(version: 20151103191550) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.boolean  "active",       default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.string   "city_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diesel_companies", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diesel_expenses", force: :cascade do |t|
    t.integer  "litres"
    t.integer  "diesel_company_id"
    t.integer  "expense_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "diesel_expenses", ["diesel_company_id"], name: "index_diesel_expenses_on_diesel_company_id"
  add_index "diesel_expenses", ["expense_id"], name: "index_diesel_expenses_on_expense_id"

  create_table "drivers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "address"
    t.string   "id_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "expense_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.integer  "expense_category_id"
    t.float    "amount"
    t.integer  "product_id"
    t.integer  "driver_id"
    t.integer  "truck_id"
    t.integer  "turn_boy_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "lpo"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.date     "date"
  end

  add_index "expenses", ["driver_id"], name: "index_expenses_on_driver_id"
  add_index "expenses", ["expense_category_id"], name: "index_expenses_on_expense_category_id"
  add_index "expenses", ["product_id"], name: "index_expenses_on_product_id"
  add_index "expenses", ["truck_id"], name: "index_expenses_on_truck_id"
  add_index "expenses", ["turn_boy_id"], name: "index_expenses_on_turn_boy_id"
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "product_type"
  end

  create_table "truck_drivers", force: :cascade do |t|
    t.integer  "truck_id"
    t.integer  "driver_id"
    t.boolean  "active",     default: false
    t.float    "salary"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "truck_drivers", ["driver_id"], name: "index_truck_drivers_on_driver_id"
  add_index "truck_drivers", ["truck_id"], name: "index_truck_drivers_on_truck_id"

  create_table "truck_owners", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "address"
    t.string   "id_number"
    t.string   "entity_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "truck_turn_boys", force: :cascade do |t|
    t.integer  "truck_id"
    t.integer  "turn_boy_id"
    t.boolean  "active"
    t.float    "salary"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "truck_turn_boys", ["truck_id"], name: "index_truck_turn_boys_on_truck_id"
  add_index "truck_turn_boys", ["turn_boy_id"], name: "index_truck_turn_boys_on_turn_boy_id"

  create_table "trucks", force: :cascade do |t|
    t.string   "registration_number"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "truck_owner_id"
  end

  add_index "trucks", ["truck_owner_id"], name: "index_trucks_on_truck_owner_id"

  create_table "turn_boys", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "address"
    t.string   "id_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
