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

class CreateDatabase < ActiveRecord::Migration
  def self.up
ActiveRecord::Schema.define(version: 0) do

  create_table "accessories", primary_key: "accessories_id", force: true do |t|
    t.text    "accessories_ean"
    t.text    "eng_title",       limit: 16777215
    t.text    "jap_title",       limit: 16777215
    t.integer "system"
    t.integer "region",                           default: 1
  end

  add_index "accessories", ["region"], name: "region", using: :btree
  add_index "accessories", ["system"], name: "system", using: :btree

  create_table "accessories_ownership", id: false, force: true do |t|
    t.integer "user_id",           default: 0, null: false
    t.integer "accessories_id",    default: 0, null: false
    t.boolean "own"
    t.boolean "complete"
    t.integer "box_condition"
    t.integer "item_condition"
    t.integer "manual_condition"
    t.integer "inserts_condition"
    t.text    "notes"
  end

  add_index "accessories_ownership", ["accessories_id"], name: "accessories_id", using: :btree

  create_table "console_general", primary_key: "console_id", force: true do |t|
    t.text "eng_name"
    t.text "jap_name"
  end

  create_table "console_ownership", id: false, force: true do |t|
    t.integer "user_id",           default: 0, null: false
    t.integer "console_id",        default: 0, null: false
    t.boolean "own"
    t.boolean "complete"
    t.integer "box_condition"
    t.integer "console_condition"
    t.integer "manual_condition"
    t.integer "inserts_condition"
    t.text    "notes"
  end

  add_index "console_ownership", ["console_id"], name: "console_id", using: :btree

  create_table "consoles", primary_key: "console_id", force: true do |t|
    t.text    "console_ean"
    t.text    "eng_name"
    t.text    "jap_name"
    t.integer "region",      default: 1
    t.integer "system"
  end

  add_index "consoles", ["region"], name: "region", using: :btree
  add_index "consoles", ["system"], name: "system", using: :btree

  create_table "games", force: true do |t|
    t.text    "ean",       limit: 16777215
    t.text    "eng_title", limit: 16777215
    t.text    "jap_title", limit: 16777215
    t.integer "system"
    t.integer "region",                     default: 1
    t.integer "image"
  end

  add_index "games", ["image"], name: "image", using: :btree
  add_index "games", ["region"], name: "region", using: :btree
  add_index "games", ["system"], name: "system", using: :btree

  create_table "image", primary_key: "image_id", force: true do |t|
    t.string    "mime_type",                                    null: false
    t.string    "filename",     default: "",                    null: false
    t.integer   "image_width"
    t.integer   "image_height"
    t.text      "description"
    t.string    "alt"
    t.integer   "user_id",                                      null: false
    t.date      "upld_date",                                    null: false
    t.time      "upld_time",    default: '2000-01-01 00:00:00', null: false
    t.timestamp "updated",                                      null: false
    t.text      "image_ean",                                    null: false
  end

  add_index "image", ["user_id"], name: "user_id", using: :btree

  create_table "image_location", primary_key: "image_location_id", force: true do |t|
    t.string    "image_path", default: ""
    t.string    "image_name", default: ""
    t.integer   "upld_by_id",              null: false
    t.timestamp "upld_on",                 null: false
  end

  add_index "image_location", ["image_location_id"], name: "ID", using: :btree
  add_index "image_location", ["image_name"], name: "search_index", using: :btree
  add_index "image_location", ["upld_by_id"], name: "upld_by_id", using: :btree

  create_table "one_hundred_percent", id: false, force: true do |t|
    t.integer "user_id", default: 0, null: false
    t.integer "game_id", default: 0, null: false
    t.text    "notes"
  end

  add_index "one_hundred_percent", ["game_id"], name: "game_id", using: :btree

  create_table "ownership", id: false, force: true do |t|
    t.integer "user_id",              default: 0, null: false
    t.integer "game_id",              default: 0, null: false
    t.boolean "own"
    t.boolean "complete"
    t.integer "box_condition"
    t.integer "game_condition"
    t.integer "manual_condition"
    t.integer "inserts_condition"
    t.text    "notes"
    t.integer "spine_card_condition"
    t.integer "count",                default: 1, null: false
  end

  add_index "ownership", ["box_condition"], name: "box_condition", using: :btree
  add_index "ownership", ["game_condition"], name: "game_condition", using: :btree
  add_index "ownership", ["game_id"], name: "game_id", using: :btree
  add_index "ownership", ["inserts_condition"], name: "inserts_condition", using: :btree
  add_index "ownership", ["manual_condition"], name: "manual_condition", using: :btree
  add_index "ownership", ["spine_card_condition"], name: "spine_card_condition", using: :btree

  create_table "quality", primary_key: "quality_id", force: true do |t|
    t.text "quality"
  end

  create_table "region", primary_key: "region_id", force: true do |t|
    t.text "region_title"
    t.text "region_country"
  end

  create_table "users", force: true do |t|
    t.text    "first_name"
    t.text    "last_name"
    t.text    "alias"
    t.binary  "password",          limit: 41
    t.boolean "create_permission"
    t.boolean "modify_permission"
  end

  create_table "wish_list", id: false, force: true do |t|
    t.integer "user_id",            default: 0,  null: false
    t.string  "ean",     limit: 14, default: "", null: false
    t.text    "notes"
  end

end
  end

  def self.down
    # drop all the tables if you really need
    # to support migration back to version 0
  end
end

