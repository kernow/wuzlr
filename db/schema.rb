# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090823180308) do

  create_table "fifa_teams", :force => true do |t|
    t.string  "name"
    t.string  "flag"
    t.integer "goals_for"
    t.integer "goals_against"
    t.integer "penalty_goal"
    t.integer "goals_for_average"
    t.integer "yellow_cards"
    t.integer "second_yellow_cards"
    t.integer "red_cards"
    t.integer "matches_played"
    t.integer "won"
    t.integer "draw"
    t.integer "lost"
  end

  create_table "league_players", :force => true do |t|
    t.integer  "league_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "league_stats", :force => true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.integer  "played",                   :default => 0
    t.integer  "won",                      :default => 0
    t.integer  "lost",                     :default => 0
    t.integer  "win_percent",              :default => 0
    t.datetime "last_played_at"
    t.datetime "last_won_at"
    t.datetime "last_lost_at"
    t.integer  "longest_winning_streak",   :default => 0
    t.integer  "longest_losing_streak",    :default => 0
    t.datetime "last_on_top_at"
    t.datetime "last_on_bottom_at"
    t.integer  "longest_on_top_streak",    :default => 0
    t.integer  "longest_on_bottom_streak", :default => 0
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "match_players", :force => true do |t|
    t.string   "team"
    t.integer  "position"
    t.integer  "match_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_stats", :force => true do |t|
    t.integer "user_id"
    t.integer "match_id"
    t.boolean "won"
    t.integer "by"
  end

  create_table "matches", :force => true do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "red_score"
    t.integer  "blue_score"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "user_stats", :force => true do |t|
    t.integer "user_id"
    t.integer "other_user_id"
    t.string  "relation"
    t.integer "match_id"
    t.boolean "won"
    t.integer "by"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :limit => 128
    t.string   "salt",                   :limit => 128
    t.string   "token",                  :limit => 128
    t.datetime "token_expires_at"
    t.boolean  "email_confirmed",                       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "played",                                :default => 0
    t.integer  "won",                                   :default => 0
    t.integer  "lost",                                  :default => 0
    t.datetime "last_played_at"
    t.datetime "last_won_at"
    t.datetime "last_lost_at"
    t.integer  "longest_winning_streak",                :default => 0
    t.integer  "longest_losing_streak",                 :default => 0
    t.float    "win_loss_percentage",                   :default => 0.0
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "token"], :name => "index_users_on_id_and_token"
  add_index "users", ["token"], :name => "index_users_on_token"

end
