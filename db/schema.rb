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

ActiveRecord::Schema.define(version: 20141222201540) do

  create_table "contributions", force: true do |t|
    t.text     "summary"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "start_month"
    t.integer  "end_month"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "location_state"
    t.string   "location_city"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "level"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incident_references", force: true do |t|
    t.integer  "incident_id"
    t.integer  "reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents", force: true do |t|
    t.string   "uuid"
    t.text     "incident_summary"
    t.integer  "incident_year"
    t.integer  "incident_month"
    t.integer  "reported_year"
    t.integer  "reported_month"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "location_state"
    t.string   "location_city"
    t.string   "location_county"
    t.text     "location_notes"
    t.string   "context"
    t.integer  "victim_count"
    t.boolean  "victim_animal"
    t.text     "victim_notes"
    t.boolean  "abuse_force"
    t.boolean  "abuse_search"
    t.boolean  "abuse_misconduct"
    t.boolean  "abuse_intimidation"
    t.boolean  "abuse_sexual"
    t.boolean  "abuse_restrained"
    t.text     "abuse_notes"
    t.integer  "outcome_dollars"
    t.integer  "department_id"
    t.integer  "officer_count"
    t.boolean  "officer_multiple_incident"
  end

  create_table "references", force: true do |t|
    t.string   "url"
    t.date     "date_accessed"
    t.string   "headline"
    t.string   "org_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "incident_id"
    t.date     "publish_date"
    t.integer  "contribution_id"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
