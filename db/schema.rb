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

ActiveRecord::Schema.define(version: 20171008102241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries_lighting_products", id: false, force: :cascade do |t|
    t.bigint "lighting_product_id", null: false
    t.bigint "country_id", null: false
  end

  create_table "distributors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "address"
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.bigint "manufacturer_id"
    t.index ["country_id"], name: "index_distributors_on_country_id"
    t.index ["manufacturer_id"], name: "index_distributors_on_manufacturer_id"
  end

  create_table "distributors_lighting_products", id: false, force: :cascade do |t|
    t.bigint "lighting_product_id", null: false
    t.bigint "distributor_id", null: false
  end

  create_table "distributors_manufacturers", id: false, force: :cascade do |t|
    t.bigint "distributor_id", null: false
    t.bigint "manufacturer_id", null: false
  end

  create_table "lighting_products", force: :cascade do |t|
    t.string "name"
    t.boolean "mobile_charging"
    t.decimal "price"
    t.integer "num_of_lights"
    t.integer "num_12v"
    t.integer "num_5v"
    t.float "daily_output"
    t.float "runtime"
    t.float "battery_capacity"
    t.integer "system_lumens"
    t.integer "product_class"
    t.integer "lamp_type"
    t.integer "max_output"
    t.string "product_url"
    t.text "product_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_stand"
    t.integer "country_id"
    t.integer "distributor_id"
    t.integer "manufacturer_id"
    t.string "product_identifier"
    t.string "image_url"
  end

  create_table "lighting_products_survey_results", id: false, force: :cascade do |t|
    t.bigint "survey_result_id", null: false
    t.bigint "lighting_product_id", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "respondents", force: :cascade do |t|
    t.string "contact_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_results", force: :cascade do |t|
    t.bigint "lighting_products_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "respondent_id"
    t.string "community_code"
    t.index ["lighting_products_id"], name: "index_survey_results_on_lighting_products_id"
    t.index ["respondent_id"], name: "index_survey_results_on_respondent_id"
  end

  add_foreign_key "distributors", "countries"
  add_foreign_key "distributors", "manufacturers"
  add_foreign_key "survey_results", "lighting_products", column: "lighting_products_id"
  add_foreign_key "survey_results", "respondents"
end
