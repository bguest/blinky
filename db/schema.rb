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

ActiveRecord::Schema.define(version: 6) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "effects", force: :cascade do |t|
    t.integer  "instruction_id"
    t.string   "type"
    t.integer  "number"
    t.string   "data"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "effects", ["instruction_id"], name: "index_effects_on_instruction_id", using: :btree

  create_table "instructions", force: :cascade do |t|
    t.integer  "sequence_id"
    t.integer  "number"
    t.text     "phrase"
    t.float    "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructions", ["sequence_id"], name: "index_instructions_on_sequence_id", using: :btree

  create_table "letters", force: :cascade do |t|
    t.integer  "number"
    t.text     "segment_order"
    t.integer  "sign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "letters", ["number"], name: "index_letters_on_number", using: :btree
  add_index "letters", ["sign_id"], name: "index_letters_on_sign_id", using: :btree

  create_table "segments", force: :cascade do |t|
    t.integer "length"
    t.integer "number"
    t.string  "color"
    t.integer "letter_id"
  end

  add_index "segments", ["letter_id"], name: "index_segments_on_letter_id", using: :btree

  create_table "sequences", force: :cascade do |t|
    t.integer  "sign_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sequences", ["sign_id"], name: "index_sequences_on_sign_id", using: :btree

  create_table "signs", force: :cascade do |t|
    t.text     "letter_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "effects", "instructions"
  add_foreign_key "instructions", "sequences"
  add_foreign_key "sequences", "signs"
end
