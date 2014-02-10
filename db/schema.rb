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

ActiveRecord::Schema.define(version: 20140210085736) do

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

  create_table "contests", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "rendered_description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "started"
    t.boolean  "ended"
    t.string   "mode"
    t.boolean  "default"
  end

  create_table "contests_hackers", id: false, force: true do |t|
    t.integer "contest_id"
    t.integer "hacker_id"
  end

  add_index "contests_hackers", ["contest_id"], name: "index_contests_hackers_on_contest_id", using: :btree
  add_index "contests_hackers", ["hacker_id"], name: "index_contests_hackers_on_hacker_id", using: :btree

  create_table "contests_puzzles", id: false, force: true do |t|
    t.integer "contest_id"
    t.integer "puzzle_id"
  end

  add_index "contests_puzzles", ["contest_id"], name: "index_contests_puzzles_on_contest_id", using: :btree
  add_index "contests_puzzles", ["puzzle_id"], name: "index_contests_puzzles_on_puzzle_id", using: :btree

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

  create_table "hackers", force: true do |t|
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
    t.string   "name"
    t.boolean  "admin"
    t.string   "language_last_use"
  end

  add_index "hackers", ["email"], name: "index_hackers_on_email", unique: true, using: :btree
  add_index "hackers", ["reset_password_token"], name: "index_hackers_on_reset_password_token", unique: true, using: :btree

  create_table "puzzles", force: true do |t|
    t.string   "title"
    t.integer  "time_limit"
    t.integer  "memory_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "rendered_description"
    t.text     "input_format"
    t.text     "rendered_input_format"
    t.text     "output_format"
    t.text     "rendered_output_format"
    t.text     "sample_input"
    t.text     "rendered_sample_input"
    t.text     "sample_output"
    t.text     "rendered_sample_output"
    t.text     "hint"
    t.text     "rendered_hint"
  end

  create_table "solutions", force: true do |t|
    t.text     "code"
    t.text     "rendered_code"
    t.string   "language"
    t.integer  "time_cost"
    t.integer  "memory_cost"
    t.string   "result"
    t.integer  "hacker_id"
    t.integer  "puzzle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contest_id"
    t.text     "compile_info"
    t.text     "rendered_compile_info"
  end

  add_index "solutions", ["contest_id"], name: "index_solutions_on_contest_id", using: :btree
  add_index "solutions", ["hacker_id"], name: "index_solutions_on_hacker_id", using: :btree
  add_index "solutions", ["puzzle_id"], name: "index_solutions_on_puzzle_id", using: :btree

  create_table "test_results", force: true do |t|
    t.string   "result"
    t.float    "score"
    t.integer  "time_cost"
    t.integer  "memory_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "solution_id"
    t.text     "log"
  end

  add_index "test_results", ["solution_id"], name: "index_test_results_on_solution_id", using: :btree

end
