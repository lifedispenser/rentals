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

ActiveRecord::Schema.define(version: 20130220162557) do

  create_table "rentals", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "bedrooms",       precision: 3, scale: 1
    t.decimal  "bathrooms",      precision: 3, scale: 1
    t.boolean  "pet_friendly",                           default: false
    t.boolean  "kid_friendly",                           default: false
    t.integer  "rate_per_night"
    t.integer  "rate_per_week"
    t.integer  "rate_per_month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
