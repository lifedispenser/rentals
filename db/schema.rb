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

ActiveRecord::Schema.define(version: 20130524044259) do

  create_table "contacts", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "from"
    t.string  "to"
    t.string  "email"
    t.string  "phone"
    t.string  "message"
    t.integer "rental_id"
  end

  create_table "photos", force: true do |t|
    t.integer  "rental_id"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "asset_fingerprint"
    t.boolean  "banner",             default: false
    t.boolean  "featured",           default: false
    t.boolean  "asset_processing"
  end

  add_index "photos", ["banner"], name: "index_photos_on_banner", using: :btree
  add_index "photos", ["featured"], name: "index_photos_on_featured", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "rentals", force: true do |t|
    t.string   "name"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.boolean  "pet_friendly",        default: false
    t.boolean  "kid_friendly",        default: false
    t.integer  "rate_per_night"
    t.integer  "rate_per_week"
    t.integer  "rate_per_month"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact"
    t.integer  "base_rate_per_night"
    t.integer  "base_rate_per_week"
    t.integer  "base_rate_per_month"
    t.string   "description"
    t.boolean  "published",           default: false
    t.boolean  "long_term",           default: false
  end

  add_index "rentals", ["bathrooms"], name: "index_rentals_on_bathrooms", using: :btree
  add_index "rentals", ["bedrooms"], name: "index_rentals_on_bedrooms", using: :btree
  add_index "rentals", ["kid_friendly"], name: "index_rentals_on_kid_friendly", using: :btree
  add_index "rentals", ["long_term"], name: "index_rentals_on_long_term", using: :btree
  add_index "rentals", ["pet_friendly"], name: "index_rentals_on_pet_friendly", using: :btree
  add_index "rentals", ["published"], name: "index_rentals_on_published", using: :btree
  add_index "rentals", ["rate_per_month"], name: "index_rentals_on_rate_per_month", using: :btree
  add_index "rentals", ["rate_per_night"], name: "index_rentals_on_rate_per_night", using: :btree
  add_index "rentals", ["rate_per_week"], name: "index_rentals_on_rate_per_week", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
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
