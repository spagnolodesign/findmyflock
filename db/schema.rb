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

ActiveRecord::Schema.define(version: 2018_06_06_032513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.text "message"
    t.boolean "application_readed", default: false
    t.boolean "contact_candidate", default: false
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_applications_on_match_id"
  end

  create_table "benefits", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competences", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cultures", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "developers", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.boolean "need_us_permit", default: false
    t.string "resume_name"
    t.string "photo_name"
    t.integer "min_salary"
    t.string "city"
    t.string "zip_code"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.integer "level"
    t.text "skills_array", default: [], array: true
    t.text "levels", default: [], array: true
    t.text "remote", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_developers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_developers_on_reset_password_token", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "recruiter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["recruiter_id"], name: "index_employees_on_recruiter_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "remote", default: [], array: true
    t.string "city"
    t.string "zip_code"
    t.string "state"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.integer "max_salary"
    t.integer "level"
    t.text "skills_array", default: [], array: true
    t.text "levels", default: [], array: true
    t.string "employment_type"
    t.text "benefits", default: [], array: true
    t.text "cultures", default: [], array: true
    t.boolean "can_sponsor", default: false
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "developer_id"
    t.boolean "application", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_matches_on_developer_id"
    t.index ["job_id"], name: "index_matches_on_job_id"
  end

  create_table "recruiters", force: :cascade do |t|
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
    t.boolean "main_recruiter", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_recruiters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_recruiters_on_reset_password_token", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.string "skillable_type"
    t.bigint "skillable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skillable_type", "skillable_id"], name: "index_skills_on_skillable_type_and_skillable_id"
  end

  add_foreign_key "applications", "matches"
  add_foreign_key "employees", "companies"
  add_foreign_key "employees", "recruiters"
  add_foreign_key "jobs", "companies"
  add_foreign_key "matches", "developers"
  add_foreign_key "matches", "jobs"
end
