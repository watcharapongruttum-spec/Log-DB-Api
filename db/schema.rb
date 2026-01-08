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

ActiveRecord::Schema[8.1].define(version: 2026_01_08_055817) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_types", force: :cascade do |t|
    t.integer "code", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_action_types_on_code", unique: true
    t.index ["name"], name: "index_action_types_on_name", unique: true
  end

  create_table "api_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "http_method"
    t.string "ip_address"
    t.jsonb "params"
    t.string "path"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_api_logs_on_user_id"
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string "action"
    t.string "action_method"
    t.bigint "action_type_id", null: false
    t.string "application_name"
    t.bigint "auditable_id"
    t.string "auditable_name"
    t.string "auditable_type"
    t.jsonb "audited_changes"
    t.string "controller_name"
    t.datetime "created_at", null: false
    t.float "duration_ms"
    t.string "http_method"
    t.string "ip"
    t.jsonb "params"
    t.datetime "performed_at"
    t.string "request_id"
    t.string "request_method"
    t.string "request_path"
    t.integer "status"
    t.text "summary"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["action_type_id"], name: "index_audit_logs_on_action_type_id"
    t.index ["auditable_type", "auditable_id"], name: "index_audit_logs_on_auditable_type_and_auditable_id"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "position"
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.string "name"
    t.decimal "price"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "role"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "api_logs", "users"
  add_foreign_key "audit_logs", "action_types"
  add_foreign_key "audit_logs", "users"
  add_foreign_key "products", "categories"
end
