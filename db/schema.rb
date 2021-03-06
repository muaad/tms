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

ActiveRecord::Schema.define(version: 20170531122801) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.boolean  "active",       default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "token"
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "name"
    t.integer  "driver_id"
    t.integer  "turn_boy_id"
    t.integer  "truck_owner_id"
    t.integer  "truck_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.date     "date_of_issue"
    t.date     "date_of_expiry"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_attachments_on_account_id"
    t.index ["driver_id"], name: "index_attachments_on_driver_id"
    t.index ["truck_id"], name: "index_attachments_on_truck_id"
    t.index ["truck_owner_id"], name: "index_attachments_on_truck_owner_id"
    t.index ["turn_boy_id"], name: "index_attachments_on_turn_boy_id"
  end

  create_table "cashes", force: :cascade do |t|
    t.date     "date"
    t.float    "amount_in"
    t.float    "amount_out"
    t.float    "balance"
    t.boolean  "closed",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "lpo"
    t.text     "description"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_cashes_on_account_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.string   "city_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_cities_on_account_id"
  end

  create_table "consignees", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.integer  "city_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_consignees_on_account_id"
    t.index ["city_id"], name: "index_consignees_on_city_id"
  end

  create_table "diesel_companies", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_diesel_companies_on_account_id"
  end

  create_table "diesel_expenses", force: :cascade do |t|
    t.integer  "litres"
    t.integer  "diesel_company_id"
    t.integer  "expense_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_diesel_expenses_on_account_id"
    t.index ["diesel_company_id"], name: "index_diesel_expenses_on_diesel_company_id"
    t.index ["expense_id"], name: "index_diesel_expenses_on_expense_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "address"
    t.string   "id_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_drivers_on_account_id"
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.string   "currency_one"
    t.string   "currency_two"
    t.float    "rate"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_exchange_rates_on_account_id"
  end

  create_table "expense_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_expense_categories_on_account_id"
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
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.date     "date"
    t.integer  "trip_id"
    t.integer  "quantity"
    t.float    "unit_price"
    t.integer  "account_id"
    t.string   "currency",            default: "Kenya Shilling"
    t.float    "dollar_amount"
    t.index ["account_id"], name: "index_expenses_on_account_id"
    t.index ["driver_id"], name: "index_expenses_on_driver_id"
    t.index ["expense_category_id"], name: "index_expenses_on_expense_category_id"
    t.index ["product_id"], name: "index_expenses_on_product_id"
    t.index ["trip_id"], name: "index_expenses_on_trip_id"
    t.index ["truck_id"], name: "index_expenses_on_truck_id"
    t.index ["turn_boy_id"], name: "index_expenses_on_turn_boy_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "attachment_id"
    t.string   "notification_type"
    t.boolean  "read",              default: false
    t.boolean  "resolved",          default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_notifications_on_account_id"
    t.index ["attachment_id"], name: "index_notifications_on_attachment_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "product_type"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_products_on_account_id"
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "truck_id"
    t.integer  "driver_id"
    t.integer  "turn_boy_id"
    t.date     "date"
    t.integer  "depot_id"
    t.integer  "destination_id"
    t.integer  "consignee_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.float    "rate"
    t.float    "amount"
    t.float    "commission"
    t.float    "short"
    t.text     "description"
    t.string   "currency"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "account_id"
    t.float    "mileage"
    t.index ["account_id"], name: "index_trips_on_account_id"
    t.index ["consignee_id"], name: "index_trips_on_consignee_id"
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["product_id"], name: "index_trips_on_product_id"
    t.index ["truck_id"], name: "index_trips_on_truck_id"
    t.index ["turn_boy_id"], name: "index_trips_on_turn_boy_id"
  end

  create_table "truck_cashes", force: :cascade do |t|
    t.integer  "truck_id"
    t.float    "amount"
    t.date     "date"
    t.string   "lpo"
    t.text     "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "direction",   default: "IN"
    t.string   "currency"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_truck_cashes_on_account_id"
    t.index ["truck_id"], name: "index_truck_cashes_on_truck_id"
  end

  create_table "truck_drivers", force: :cascade do |t|
    t.integer  "truck_id"
    t.integer  "driver_id"
    t.boolean  "active",     default: false
    t.float    "salary"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_truck_drivers_on_account_id"
    t.index ["driver_id"], name: "index_truck_drivers_on_driver_id"
    t.index ["truck_id"], name: "index_truck_drivers_on_truck_id"
  end

  create_table "truck_owners", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "address"
    t.string   "id_number"
    t.string   "entity_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_truck_owners_on_account_id"
  end

  create_table "truck_turn_boys", force: :cascade do |t|
    t.integer  "truck_id"
    t.integer  "turn_boy_id"
    t.boolean  "active"
    t.float    "salary"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_truck_turn_boys_on_account_id"
    t.index ["truck_id"], name: "index_truck_turn_boys_on_truck_id"
    t.index ["turn_boy_id"], name: "index_truck_turn_boys_on_turn_boy_id"
  end

  create_table "trucks", force: :cascade do |t|
    t.string   "registration_number"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "truck_owner_id"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_trucks_on_account_id"
    t.index ["truck_owner_id"], name: "index_trucks_on_truck_owner_id"
  end

  create_table "turn_boys", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "address"
    t.string   "id_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_turn_boys_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.integer  "account_id"
    t.boolean  "is_admin",               default: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
