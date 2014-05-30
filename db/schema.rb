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

ActiveRecord::Schema.define(version: 20140530101452) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "active",      default: false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "categories", force: true do |t|
    t.string   "description"
    t.integer  "activity_id"
    t.float    "distance"
    t.integer  "age_from"
    t.integer  "age_to"
    t.string   "gender"
    t.integer  "start_startnumber"
    t.datetime "start_time"
  end

  add_index "categories", ["activity_id"], name: "index_categories_on_activity_id", using: :btree

  create_table "participants", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "street"
    t.string   "zipcode"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.date     "date_of_birth"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street_number"
    t.string   "uuid",          null: false
  end

  add_index "participants", ["uuid"], name: "index_participants_on_uuid", using: :btree

  create_table "participations", force: true do |t|
    t.integer "participant_id"
    t.integer "activity_id"
    t.date    "end_time"
    t.date    "total_time"
    t.integer "ranking"
    t.integer "category_id"
  end

  add_index "participations", ["activity_id"], name: "index_participations_on_activity_id", using: :btree
  add_index "participations", ["category_id"], name: "index_participations_on_category_id", using: :btree
  add_index "participations", ["participant_id"], name: "index_participations_on_participant_id", using: :btree

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
