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

ActiveRecord::Schema.define(version: 20170429223019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "post_id"
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "divisions", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "matches", force: :cascade do |t|
    t.date     "date"
    t.time     "time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "visit_team_id"
    t.integer  "home_team_id"
    t.integer  "tournament_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id", using: :btree
    t.index ["tournament_id"], name: "index_matches_on_tournament_id", using: :btree
    t.index ["visit_team_id"], name: "index_matches_on_visit_team_id", using: :btree
  end

  create_table "performances", force: :cascade do |t|
    t.integer  "goals",        null: false
    t.integer  "yellow_cards", null: false
    t.integer  "red_cards",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "match_id"
    t.integer  "user_id"
    t.index ["match_id"], name: "index_performances_on_match_id", using: :btree
    t.index ["user_id"], name: "index_performances_on_user_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.date     "date",               null: false
    t.text     "comment",            null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "match_id"
    t.index ["match_id"], name: "index_pictures_on_match_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",              null: false
    t.integer  "points"
    t.integer  "won"
    t.integer  "lost"
    t.integer  "tie"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.string   "season",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "division_id"
    t.index ["division_id"], name: "index_tournaments_on_division_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "position"
    t.boolean  "is_admin"
    t.boolean  "is_captain"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "matches", "teams", column: "visit_team_id"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "performances", "matches"
  add_foreign_key "performances", "users"
  add_foreign_key "pictures", "matches"
  add_foreign_key "posts", "users"
  add_foreign_key "tournaments", "divisions"
end