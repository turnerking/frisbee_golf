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

ActiveRecord::Schema.define(:version => 20100322223246) do

  create_table "challengers", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "challenge_id"
  end

  create_table "challenges", :force => true do |t|
    t.integer  "organizer_id"
    t.integer  "course_id"
    t.datetime "play_from"
    t.datetime "play_to"
    t.datetime "submit_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "tee_type"
    t.integer  "difficulty"
    t.integer  "tree_interference"
    t.string   "hole_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.datetime "approved_at"
    t.integer  "requester_id"
    t.integer  "approver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "friendship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holes", :force => true do |t|
    t.integer  "number"
    t.integer  "par"
    t.integer  "distance_in_ft"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "difficulty"
    t.integer  "tree_interference"
    t.integer  "course_quality"
  end

  create_table "scorecards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "weather"
    t.string   "temperature"
    t.datetime "played_at"
    t.string   "ground_conditions"
    t.float    "hours_to_play"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", :force => true do |t|
    t.integer  "scorecard_id"
    t.integer  "shots"
    t.integer  "par"
    t.integer  "number"
    t.integer  "distance_in_ft"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "gender",                    :limit => 2
    t.string   "state",                     :limit => 40
    t.boolean  "admin",                                    :default => false
    t.date     "birth_date"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
