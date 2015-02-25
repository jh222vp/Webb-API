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

ActiveRecord::Schema.define(version: 20150225081010) do

  create_table "creators", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resturants", force: true do |t|
    t.integer  "position_id"
    t.integer  "creator_id"
    t.string   "name",        limit: 25
    t.string   "description", limit: 254
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resturants_tags", force: true do |t|
    t.integer "tag_id"
    t.integer "resturant_id"
  end

  create_table "tags", force: true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",            limit: 25
    t.string   "key"
    t.boolean  "admin",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
