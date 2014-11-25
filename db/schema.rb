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

ActiveRecord::Schema.define(version: 20141125014725) do

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

  create_table "advertisers_listings", id: false, force: true do |t|
    t.integer "advertiser_id", null: false
    t.integer "listing_id",    null: false
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "listings", force: true do |t|
    t.string   "title"
    t.float    "height"
    t.float    "width"
    t.integer  "time_per_click"
    t.integer  "views_per_week"
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
    t.float    "cost_per_day"
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

  create_table "models", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models", ["email"], name: "index_models_on_email", unique: true, using: :btree
  add_index "models", ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true, using: :btree

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

  create_table "reservations", force: true do |t|
    t.integer  "listing_id"
    t.integer  "advertiser_id"
    t.integer  "advertisement_id"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_date"
    t.date     "start_date"
    t.boolean  "completed"
    t.string   "order"
  end

  add_index "reservations", ["advertisement_id"], name: "index_reservations_on_advertisement_id", using: :btree
  add_index "reservations", ["advertiser_id"], name: "index_reservations_on_advertiser_id", using: :btree
  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree

end
