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

ActiveRecord::Schema.define(version: 20171227171344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "is_admin", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.string "meta_title"
    t.text "small_description"
    t.text "meta_description"
    t.string "slug"
    t.text "content"
    t.string "small_image"
    t.date "date"
    t.string "author"
    t.boolean "visible"
    t.string "lead_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hero_image"
    t.text "introduction"
    t.text "description"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "slug"
    t.string "small_image"
    t.string "category_type"
    t.boolean "visible"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_check"
  end

  create_table "categorizings", force: :cascade do |t|
    t.bigint "category_id"
    t.string "categorizable_type"
    t.bigint "categorizable_id"
    t.integer "rank_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categorizable_type", "categorizable_id"], name: "index_categorizings_on_categorizable_type_and_categorizable_id"
    t.index ["category_id"], name: "index_categorizings_on_category_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "small_image"
    t.string "zipcode"
    t.string "external_url"
    t.string "slug"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_cities_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "small_image"
    t.integer "department_number"
    t.string "external_url"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "greffes", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.string "scrap_coordinates"
    t.float "latitude"
    t.float "longitude"
    t.text "scrap_address", default: [], array: true
    t.text "address"
    t.string "zip_code"
    t.string "phone"
    t.string "fax"
    t.string "website_url"
    t.text "schedule"
    t.text "clerks", default: [], array: true
    t.string "tribunal_type"
    t.string "monday_hours"
    t.string "tuesday_hours"
    t.string "wednesday_hours"
    t.string "thursday_hours"
    t.string "friday_hours"
    t.string "saturday_hours"
    t.string "sunday_hours"
    t.string "slug"
    t.integer "priority_order"
    t.json "scrap_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "department_id"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_greffes_on_city_id"
    t.index ["department_id"], name: "index_greffes_on_department_id"
  end

  create_table "media", force: :cascade do |t|
    t.string "name"
    t.string "internal_name"
    t.text "description"
    t.integer "popularity_order"
    t.string "medium_kind"
    t.string "video_link"
    t.string "small_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recalls", force: :cascade do |t|
    t.string "phone"
    t.datetime "recall_date"
    t.boolean "recall_now"
    t.text "reason"
    t.string "origin"
    t.boolean "recall_sent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommandations", force: :cascade do |t|
    t.bigint "greffe_id"
    t.string "email"
    t.string "author"
    t.integer "rating"
    t.text "comment"
    t.boolean "visible"
    t.boolean "admin_check"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["greffe_id"], name: "index_recommandations_on_greffe_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "research_name"
    t.text "description"
    t.integer "popularity_order"
    t.string "slug"
    t.string "small_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categorizings", "categories"
  add_foreign_key "cities", "departments"
  add_foreign_key "greffes", "cities"
  add_foreign_key "greffes", "departments"
  add_foreign_key "recommandations", "greffes"
  add_foreign_key "taggings", "tags"
end
