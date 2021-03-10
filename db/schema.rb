# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_08_141241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_autocomplete_package_item_descriptions", force: :cascade do |t|
    t.string "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["value"], name: "index_admin_autocomplete_package_item_descriptions_on_value", unique: true
  end

  create_table "guests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "package_items", force: :cascade do |t|
    t.string "description"
    t.decimal "price", precision: 8, scale: 2
    t.integer "qty", limit: 2, default: 1
    t.bigint "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_package_items_on_package_id"
  end

  create_table "package_photos", force: :cascade do |t|
    t.jsonb "image_data"
    t.bigint "package_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["package_id"], name: "index_package_photos_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "tracking"
    t.decimal "weight", precision: 8, scale: 2
    t.bigint "user_id"
    t.bigint "guest_id"
    t.bigint "shipment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carrier", default: 0
    t.datetime "processed_at"
    t.integer "status_warehouse", default: 0
    t.datetime "received_at"
    t.index ["guest_id"], name: "index_packages_on_guest_id"
    t.index ["shipment_id"], name: "index_packages_on_shipment_id"
    t.index ["tracking"], name: "index_packages_on_tracking", unique: true
    t.index ["user_id"], name: "index_packages_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "passport_photos", force: :cascade do |t|
    t.jsonb "image_data"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_passport_photos_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "shipment_next_dates", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "air_waybill"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.boolean "admin", default: false
    t.boolean "super_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "package_items", "packages"
  add_foreign_key "package_photos", "packages"
  add_foreign_key "packages", "guests"
  add_foreign_key "packages", "shipments"
  add_foreign_key "packages", "users"
  add_foreign_key "passport_photos", "profiles"
  add_foreign_key "profiles", "users"
end
