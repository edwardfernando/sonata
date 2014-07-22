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

ActiveRecord::Schema.define(version: 20140703144853) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

# Could not dump table "attachments" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "people", force: true do |t|
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
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_expires_at"
    t.string   "avatar_url"
    t.string   "random_id"
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.integer  "is_approved",            default: 0
    t.datetime "approved_date"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthday"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true
  add_index "people", ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "service_id"
    t.integer  "person_id"
    t.integer  "role_id"
    t.integer  "is_confirmed", default: 0
    t.datetime "confirmed_at"
    t.string   "reasons"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["person_id"], name: "index_schedules_on_person_id"
  add_index "schedules", ["role_id"], name: "index_schedules_on_role_id"
  add_index "schedules", ["service_id", "person_id", "role_id"], name: "index_schedules_on_service_id_and_person_id_and_role_id", unique: true
  add_index "schedules", ["service_id"], name: "index_schedules_on_service_id"

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skillsets", force: true do |t|
    t.integer  "person_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skillsets", ["person_id", "role_id"], name: "index_skillsets_on_person_id_and_role_id", unique: true
  add_index "skillsets", ["person_id"], name: "index_skillsets_on_person_id"
  add_index "skillsets", ["role_id"], name: "index_skillsets_on_role_id"

end
