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

ActiveRecord::Schema.define(version: 20150304170753) do

  create_table "building_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "title",      limit: 255
    t.integer  "status",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "buildings", force: :cascade do |t|
    t.integer  "building_type_id", limit: 4
    t.string   "name",             limit: 255
    t.string   "title",            limit: 255
    t.integer  "status",           limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "buildings", ["building_type_id"], name: "index_buildings_on_building_type_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.decimal  "price",                     precision: 10, default: 0
    t.boolean  "stock",       limit: 1,                    default: true
    t.integer  "status",      limit: 4,                    default: 0
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "red_wine_children", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "age",        limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "red_wine_children", ["name"], name: "index_red_wine_children_on_name", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "title",      limit: 255
    t.integer  "status",     limit: 4,   default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "role_id",         limit: 4
    t.string   "last_name",       limit: 255,             null: false
    t.string   "first_name",      limit: 255,             null: false
    t.date     "birthday"
    t.string   "email",           limit: 255,             null: false
    t.string   "phone",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "remember_digest", limit: 255
    t.integer  "status",          limit: 4,   default: 0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "buildings", "building_types"
  add_foreign_key "users", "roles"
end
