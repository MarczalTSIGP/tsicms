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

ActiveRecord::Schema.define(version: 2018_09_10_214817) do

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

  create_table "faqs", force: :cascade do |t|
    t.string "title"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_recommendations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_category_recommendations_on_name", unique: true
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

  create_table "professors", force: :cascade do |t|
    t.string "name"
    t.string "lattes"
    t.text "occupation_area"
    t.string "email"
    t.bigint "professor_title_id"
    t.bigint "professor_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professor_category_id"], name: "index_professors_on_professor_category_id"
    t.index ["professor_title_id"], name: "index_professors_on_professor_title_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.bigint "category_recommendation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_recommendation_id"], name: "index_recommendations_on_category_recommendation_id"
  end

  add_foreign_key "professors", "professor_categories"
  add_foreign_key "professors", "professor_titles"
end
