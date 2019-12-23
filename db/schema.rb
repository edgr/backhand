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

ActiveRecord::Schema.define(version: 2019_12_23_043748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shortname"
    t.string "address"
    t.string "email"
    t.string "phone_number"
    t.text "description"
    t.string "website"
    t.string "picture"
    t.float "latitude"
    t.float "longitude"
    t.string "access"
  end

  create_table "computed_skills_sets", force: :cascade do |t|
    t.bigint "user_id"
    t.float "serve", default: 5.0
    t.float "return", default: 5.0
    t.float "backhand", default: 5.0
    t.float "forehand", default: 5.0
    t.float "volley", default: 5.0
    t.float "speed", default: 5.0
    t.float "power", default: 5.0
    t.float "endurance", default: 5.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_computed_skills_sets_on_user_id"
  end

  create_table "courts", force: :cascade do |t|
    t.string "name"
    t.string "surface"
    t.boolean "indoor", default: false
    t.boolean "single", default: false
    t.boolean "lights", default: false
    t.boolean "water", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.bigint "club_id"
    t.index ["club_id"], name: "index_courts_on_club_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "player_1_id"
    t.bigint "player_2_id"
    t.bigint "player_3_id"
    t.bigint "player_4_id"
    t.datetime "date_time"
    t.bigint "club_id"
    t.integer "event_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_events_on_club_id"
    t.index ["player_1_id"], name: "index_events_on_player_1_id"
    t.index ["player_2_id"], name: "index_events_on_player_2_id"
    t.index ["player_3_id"], name: "index_events_on_player_3_id"
    t.index ["player_4_id"], name: "index_events_on_player_4_id"
  end

  create_table "match_results", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "winner_id"
    t.bigint "loser_id"
    t.string "score"
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loser_id"], name: "index_match_results_on_loser_id"
    t.index ["match_id"], name: "index_match_results_on_match_id"
    t.index ["winner_id"], name: "index_match_results_on_winner_id"
  end

  create_table "match_sets", force: :cascade do |t|
    t.bigint "match_id"
    t.integer "player_1_games"
    t.integer "player_2_games"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_sets_on_match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "player_1_id"
    t.bigint "player_2_id"
    t.date "date"
    t.bigint "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_matches_on_club_id"
    t.index ["player_1_id"], name: "index_matches_on_player_1_id"
    t.index ["player_2_id"], name: "index_matches_on_player_2_id"
  end

  create_table "shoutouts", force: :cascade do |t|
    t.text "recipients"
    t.integer "minimum_level"
    t.text "message"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "maximum_level"
    t.index ["user_id"], name: "index_shoutouts_on_user_id"
  end

  create_table "user_reviews", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.integer "serve"
    t.integer "return"
    t.integer "backhand"
    t.integer "volley"
    t.integer "speed"
    t.integer "power"
    t.integer "endurance"
    t.boolean "thumb"
    t.integer "forehand"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_user_reviews_on_receiver_id"
    t.index ["sender_id"], name: "index_user_reviews_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "level"
    t.text "bio"
    t.string "address"
    t.string "place_of_birth"
    t.string "user_name"
    t.string "style_of_play"
    t.string "gender"
    t.string "country"
    t.string "picture"
    t.integer "ranking"
    t.integer "height"
    t.integer "weight"
    t.float "latitude"
    t.float "longitude"
    t.date "birthday"
    t.float "points", default: 1200.0
    t.string "handedness"
    t.string "backhand_style"
    t.bigint "club_id"
    t.integer "review_score"
    t.string "status", default: ""
    t.integer "angle", default: 0
    t.index ["club_id"], name: "index_users_on_club_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "computed_skills_sets", "users"
  add_foreign_key "courts", "clubs"
  add_foreign_key "events", "clubs"
  add_foreign_key "events", "users", column: "player_1_id"
  add_foreign_key "events", "users", column: "player_2_id"
  add_foreign_key "events", "users", column: "player_3_id"
  add_foreign_key "events", "users", column: "player_4_id"
  add_foreign_key "match_results", "matches"
  add_foreign_key "match_results", "users", column: "loser_id"
  add_foreign_key "match_results", "users", column: "winner_id"
  add_foreign_key "match_sets", "matches"
  add_foreign_key "matches", "clubs"
  add_foreign_key "matches", "users", column: "player_1_id"
  add_foreign_key "matches", "users", column: "player_2_id"
  add_foreign_key "shoutouts", "users"
  add_foreign_key "user_reviews", "users", column: "receiver_id"
  add_foreign_key "user_reviews", "users", column: "sender_id"
  add_foreign_key "users", "clubs"
end
