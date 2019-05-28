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

ActiveRecord::Schema.define(version: 2019_05_28_132154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.bigint "challenger_id"
    t.bigint "challengee_id"
    t.string "score"
    t.string "winner"
    t.string "loser"
    t.string "location"
    t.string "status"
    t.string "proposed_time_slots"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challengee_id"], name: "index_challenges_on_challengee_id"
    t.index ["challenger_id"], name: "index_challenges_on_challenger_id"
  end
  
  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "tags", force: :cascade do |t|
    t.string "content"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_reviews", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.bigint "challenge_id"
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
    t.index ["challenge_id"], name: "index_user_reviews_on_challenge_id"
    t.index ["receiver_id"], name: "index_user_reviews_on_receiver_id"
    t.index ["sender_id"], name: "index_user_reviews_on_sender_id"
  end

  create_table "user_tags", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "tags_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tags_id"], name: "index_user_tags_on_tags_id"
    t.index ["users_id"], name: "index_user_tags_on_users_id"
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
    t.string "nationality"
    t.string "picture"
    t.integer "elo_ranking"
    t.integer "height"
    t.integer "weight"
    t.integer "latitude"
    t.integer "longitude"
    t.date "birthday"
    t.integer "total_points"
    t.bigint "club_id"
    t.index ["club_id"], name: "index_users_on_club_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "challenges", "users", column: "challengee_id"
  add_foreign_key "challenges", "users", column: "challenger_id"
  add_foreign_key "user_reviews", "challenges"
  add_foreign_key "user_reviews", "users", column: "receiver_id"
  add_foreign_key "user_reviews", "users", column: "sender_id"
  add_foreign_key "user_tags", "tags", column: "tags_id"
  add_foreign_key "user_tags", "users", column: "users_id"
  add_foreign_key "users", "clubs"
  add_foreign_key "computed_skills_sets", "users"
end
