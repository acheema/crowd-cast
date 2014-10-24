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

ActiveRecord::Schema.define(version: 20141024175659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisers", force: true do |t|
    t.string   "username"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "email"
    t.string   "company"
    t.integer  "usertype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", force: true do |t|
    t.string   "title"
    t.float    "height"
    t.float    "width"
    t.integer  "time_per_click"
    t.integer  "clicks_per_week"
    t.float    "cost_per_week"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "screen_resolution"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listings", ["owner_id"], name: "index_listings_on_owner_id", using: :btree

  create_table "owners", force: true do |t|
    t.string   "username"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "email"
    t.string   "company"
    t.integer  "usertype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
