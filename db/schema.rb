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

ActiveRecord::Schema.define(version: 20131205133144) do

  create_table "collections", force: true do |t|
    t.integer  "countries_currency_id", null: false
    t.integer  "user_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["countries_currency_id", "user_id"], name: "index_collections_on_countries_currency_id_and_user_id", unique: true
  add_index "collections", ["countries_currency_id"], name: "index_collections_on_countries_currency_id"
  add_index "collections", ["user_id"], name: "index_collections_on_user_id"

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "countries", ["code"], name: "index_countries_on_code", unique: true

  create_table "countries_currencies", force: true do |t|
    t.integer  "country_id",  null: false
    t.integer  "currency_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries_currencies", ["country_id", "currency_id"], name: "index_countries_currencies_on_country_id_and_currency_id", unique: true
  add_index "countries_currencies", ["country_id"], name: "index_countries_currencies_on_country_id"
  add_index "countries_currencies", ["currency_id"], name: "index_countries_currencies_on_currency_id"

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "currencies", ["code"], name: "index_currencies_on_code", unique: true

  create_table "users", force: true do |t|
    t.string   "email",               null: false
    t.string   "encrypted_password",  null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
