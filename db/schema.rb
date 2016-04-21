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

ActiveRecord::Schema.define(version: 20160417204755) do

  create_table "character_levels", force: :cascade do |t|
    t.string  "level_class"
    t.integer "character_id"
  end

  add_index "character_levels", ["character_id"], name: "index_character_levels_on_character_id"

  create_table "characters", force: :cascade do |t|
    t.string  "name"
    t.string  "race"
    t.text    "background"
    t.text    "config_data"
    t.integer "player_id"
  end

  add_index "characters", ["player_id"], name: "index_characters_on_player_id"

  create_table "characters_items", id: false, force: :cascade do |t|
    t.integer "character_id"
    t.integer "item_id"
  end

  create_table "characters_special_attributes", id: false, force: :cascade do |t|
    t.integer "character_id"
    t.integer "special_attribute_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "weight"
    t.string  "name"
    t.string  "group"
    t.string  "slug"
    t.text    "config_data"
  end

  add_index "items", ["group"], name: "index_items_on_group"
  add_index "items", ["slug"], name: "index_items_on_slug"

  create_table "items_special_attributes", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "special_attribute_id"
  end

  create_table "journal_entries", force: :cascade do |t|
    t.string  "title"
    t.text    "content"
    t.integer "character_id"
  end

  create_table "player_sessions", force: :cascade do |t|
    t.string   "session_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_sessions", ["player_id"], name: "index_player_sessions_on_player_id"
  add_index "player_sessions", ["session_id"], name: "index_player_sessions_on_session_id"

  create_table "players", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "player_tag"
    t.text   "bio"
    t.string "profile_image"
    t.string "auth_token"
    t.string "activated"
  end

  add_index "players", ["email"], name: "index_players_on_email"
  add_index "players", ["player_tag"], name: "index_players_on_player_tag"

  create_table "roles", force: :cascade do |t|
    t.string  "name"
    t.integer "player_id"
  end

  add_index "roles", ["player_id"], name: "index_roles_on_player_id"

  create_table "special_attributes", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "group"
    t.text   "description"
    t.text   "config_data", default: "{}"
  end

  add_index "special_attributes", ["slug"], name: "index_special_attributes_on_slug"

end
