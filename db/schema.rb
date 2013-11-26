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

ActiveRecord::Schema.define(version: 20131125212834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

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

  add_index "logs", ["checklist_id"], name: "index_logs_on_checklist_id", using: :btree
  add_index "logs", ["scribe_id"], name: "index_logs_on_scribe_id", using: :btree
  add_index "logs", ["team_id"], name: "index_logs_on_team_id", using: :btree

  create_table "snapshot_alphas", force: true do |t|
    t.integer  "snapshot_id"
    t.integer  "alpha_id"
    t.integer  "scribe_id"
    t.integer  "current_state_id"
    t.text     "notes"
    t.text     "actions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "snapshot_alphas", ["alpha_id"], name: "index_snapshot_alphas_on_alpha_id", using: :btree
  add_index "snapshot_alphas", ["current_state_id"], name: "index_snapshot_alphas_on_current_state_id", using: :btree
  add_index "snapshot_alphas", ["scribe_id"], name: "index_snapshot_alphas_on_scribe_id", using: :btree
  add_index "snapshot_alphas", ["snapshot_id", "alpha_id"], name: "index_snapshot_alphas_on_snapshot_id_and_alpha_id", unique: true, using: :btree
  add_index "snapshot_alphas", ["snapshot_id"], name: "index_snapshot_alphas_on_snapshot_id", using: :btree

  create_table "snapshot_checklists", force: true do |t|
    t.integer  "snapshot_id"
    t.integer  "checklist_id"
    t.integer  "scribe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "snapshot_checklists", ["checklist_id"], name: "index_snapshot_checklists_on_checklist_id", using: :btree
  add_index "snapshot_checklists", ["scribe_id"], name: "index_snapshot_checklists_on_scribe_id", using: :btree
  add_index "snapshot_checklists", ["snapshot_id", "checklist_id"], name: "index_snapshot_checklists_on_snapshot_id_and_checklist_id", unique: true, using: :btree
  add_index "snapshot_checklists", ["snapshot_id"], name: "index_snapshot_checklists_on_snapshot_id", using: :btree

  create_table "snapshots", force: true do |t|
    t.integer  "team_id"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "snapshots", ["team_id", "order"], name: "index_snapshots_on_team_id_and_order", unique: true, using: :btree
  add_index "snapshots", ["team_id"], name: "index_snapshots_on_team_id", using: :btree

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

  add_index "team_checklists", ["checklist_id"], name: "index_team_checklists_on_checklist_id", using: :btree
  add_index "team_checklists", ["scribe_id"], name: "index_team_checklists_on_scribe_id", using: :btree
  add_index "team_checklists", ["team_id", "checklist_id"], name: "index_team_checklists_on_team_id_and_checklist_id", unique: true, using: :btree
  add_index "team_checklists", ["team_id"], name: "index_team_checklists_on_team_id", using: :btree

  create_table "team_users", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_users", ["team_id"], name: "index_team_users_on_team_id", using: :btree
  add_index "team_users", ["user_id"], name: "index_team_users_on_user_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["owner_id"], name: "index_teams_on_owner_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
