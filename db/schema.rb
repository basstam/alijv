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

ActiveRecord::Schema.define(version: 20140413182615) do

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
  end

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

end
