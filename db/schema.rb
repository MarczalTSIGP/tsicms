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

ActiveRecord::Schema.define(version: 2018_10_27_024948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academics", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "contact"
    t.boolean "graduated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_professors", force: :cascade do |t|
    t.bigint "professor_id"
    t.bigint "activity_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_professors_on_activity_id"
    t.index ["professor_id"], name: "index_activity_professors_on_professor_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "image"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "category_recommendations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_category_recommendations_on_name", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "operation"
    t.string "site"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discipline_monitor_professors", force: :cascade do |t|
    t.integer "professor_id"
    t.integer "discipline_monitor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discipline_monitors", force: :cascade do |t|
    t.integer "year"
    t.integer "semester"
    t.text "description"
    t.bigint "academic_id"
    t.bigint "monitor_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_id"], name: "index_discipline_monitors_on_academic_id"
    t.index ["monitor_type_id"], name: "index_discipline_monitors_on_monitor_type_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "hours"
    t.string "menu"
    t.bigint "period_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["period_id"], name: "index_disciplines_on_period_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "title"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matrices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monitor_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periods", force: :cascade do |t|
    t.string "name"
    t.bigint "matrix_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matrix_id"], name: "index_periods_on_matrix_id"
  end

  create_table "professor_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professor_titles", force: :cascade do |t|
    t.string "name"
    t.string "abbrev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "professors" because of following StandardError
#   Unknown type 'professor_genders' for column 'gender'

  create_table "recommendations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.bigint "category_recommendation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_recommendation_id"], name: "index_recommendations_on_category_recommendation_id"
  end

  create_table "static_pages", force: :cascade do |t|
    t.string "title"
    t.string "sub_title"
    t.text "content"
    t.string "permalink"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permalink"], name: "index_static_pages_on_permalink", unique: true
  end

  create_table "trainee_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainees", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "company_id"
    t.bigint "trainee_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_trainees_on_company_id"
    t.index ["trainee_status_id"], name: "index_trainees_on_trainee_status_id"
  end

  add_foreign_key "discipline_monitors", "academics"
  add_foreign_key "discipline_monitors", "monitor_types"
  add_foreign_key "disciplines", "periods"
  add_foreign_key "periods", "matrices"
  add_foreign_key "professors", "professor_categories"
  add_foreign_key "professors", "professor_titles"
  add_foreign_key "trainees", "companies"
  add_foreign_key "trainees", "trainee_statuses"
end
