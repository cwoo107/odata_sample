# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_26_170450) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "credentials", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "collection_id"
    t.index ["user_id"], name: "index_credentials_on_user_id"
  end

  create_table "filter_groups", force: :cascade do |t|
    t.bigint "odata_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "built_filter_group"
    t.index ["odata_request_id"], name: "index_filter_groups_on_odata_request_id"
  end

  create_table "filters", force: :cascade do |t|
    t.bigint "filter_group_id", null: false
    t.string "filter_field"
    t.string "operator"
    t.string "filter_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "built_filter"
    t.index ["filter_group_id"], name: "index_filters_on_filter_group_id"
  end

  create_table "odata_requests", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.string "name"
    t.text "description"
    t.string "base_url"
    t.string "url"
    t.bigint "authorization"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["collection_id"], name: "index_odata_requests_on_collection_id"
    t.index ["user_id"], name: "index_odata_requests_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.string "name"
    t.text "description"
    t.string "base_url"
    t.string "url"
    t.bigint "authorization"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_requests_on_collection_id"
  end

  create_table "select_fields", force: :cascade do |t|
    t.string "field_name"
    t.bigint "odata_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["odata_request_id"], name: "index_select_fields_on_odata_request_id"
  end

  create_table "urls", force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "collection_id"
    t.index ["user_id"], name: "index_urls_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "collections", "users"
  add_foreign_key "credentials", "users"
  add_foreign_key "filter_groups", "odata_requests"
  add_foreign_key "filters", "filter_groups"
  add_foreign_key "odata_requests", "collections"
  add_foreign_key "odata_requests", "users"
  add_foreign_key "requests", "collections"
  add_foreign_key "select_fields", "odata_requests"
  add_foreign_key "urls", "users"
end
