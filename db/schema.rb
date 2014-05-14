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

ActiveRecord::Schema.define(version: 20140513150849) do

  create_table "people", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "service_id"
    t.integer  "person_id"
    t.integer  "role_id"
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
