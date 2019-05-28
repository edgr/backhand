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

ActiveRecord::Schema.define(version: 2019_05_28_094354) do

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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "challenges", "users", column: "challengee_id"
  add_foreign_key "challenges", "users", column: "challenger_id"
end
