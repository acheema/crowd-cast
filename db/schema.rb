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

ActiveRecord::Schema.define(version: 20141115011103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisements", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "width"
    t.integer  "height"
    t.integer  "advertiser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ad_file_name"
    t.string   "ad_content_type"
    t.integer  "ad_file_size"
    t.datetime "ad_updated_at"
  end

  add_index "advertisements", ["advertiser_id"], name: "index_advertisements_on_advertiser_id", using: :btree

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
    t.integer  "views_per_week"
    t.float    "cost_per_week"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "screen_resolution_x"
    t.integer  "screen_resolution_y"
    t.integer  "views"
    t.boolean  "active"
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "listings", ["owner_id"], name: "index_listings_on_owner_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "listing_id"
    t.string   "to_username"
    t.string   "from_username"
    t.integer  "message_type"
    t.string   "viewed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text"
    t.string   "listing_title"
  end

  add_index "messages", ["listing_id"], name: "index_messages_on_listing_id", using: :btree

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
