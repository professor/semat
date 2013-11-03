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

ActiveRecord::Schema.define(version: 20131101222334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alphas", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.string   "concern"
    t.string   "definition"
    t.text     "description"
    t.integer  "order"
    t.integer  "essence_version_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklists", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "essence_versions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.integer  "team_id"
    t.integer  "checklist_id"
    t.integer  "scribe_id"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "alpha_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_checklists", force: true do |t|
    t.integer  "team_id"
    t.integer  "checklist_id"
    t.integer  "scribe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
