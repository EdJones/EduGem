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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110426123906) do

  create_table "accounts", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "answer_key"
  end

  create_table "assessments", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "assessment_type"
  end

  create_table "bonus_rounds", :force => true do |t|
    t.integer  "level"
    t.string   "message1"
    t.string   "message2"
    t.integer  "points"
    t.string   "points_message"
    t.string   "level_up_message"
    t.string   "modifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "choice"
  end

  create_table "custom_events", :force => true do |t|
    t.integer  "game_id"
    t.integer  "idee"
    t.string   "title"
    t.integer  "pointValue",  :default => 1000
    t.string   "description"
    t.integer  "year",        :default => 3000
    t.string   "wikip_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
    t.integer  "my_digi_id"
    t.boolean  "public"
    t.string   "author",      :default => "ej0c"
    t.boolean  "scale",       :default => false
  end

  create_table "custom_events_my_digis", :id => false, :force => true do |t|
    t.integer "my_digi_id",      :null => false
    t.integer "custom_event_id", :null => false
  end

  create_table "event_suggestions", :force => true do |t|
    t.string   "title"
    t.string   "user"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer "idee"
    t.string  "title"
    t.text    "description"
    t.string  "image_url"
    t.integer "year"
    t.integer "pointValue",  :default => 1000
    t.string  "wikip_url"
  end

  create_table "game_builds", :force => true do |t|
    t.integer  "gameId"
    t.integer  "level"
    t.integer  "sublevel"
    t.integer  "numEvents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_levels", :force => true do |t|
    t.integer  "game_id"
    t.integer  "level"
    t.integer  "sublevel"
    t.integer  "start_idee"
    t.integer  "end_idee"
    t.string   "tagline"
    t.binary   "custom_digi"
    t.integer  "my_digi_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "modifier"
  end

  create_table "game_stats", :force => true do |t|
    t.string   "login"
    t.integer  "game_id"
    t.integer  "high_score"
    t.datetime "start_time"
    t.integer  "last_level"
    t.integer  "game_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.datetime "sent_at"
  end

  create_table "mchoices", :force => true do |t|
    t.string   "prompt"
    t.string   "answer1"
    t.string   "answer2"
    t.string   "anser3"
    t.string   "answer4"
    t.string   "hint"
    t.integer  "correct"
    t.string   "errormsg1"
    t.string   "errormsg2"
    t.string   "errormsg3"
    t.string   "errormsg4"
    t.string   "modifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_digis", :force => true do |t|
    t.string   "author"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "theme"
    t.integer  "group"
    t.boolean  "public_play", :default => false
    t.boolean  "public",      :default => false
  end

  create_table "my_digis_my_games", :id => false, :force => true do |t|
    t.integer "my_digi_id", :null => false
    t.integer "my_game_id", :null => false
  end

  add_index "my_digis_my_games", ["my_game_id", "my_digi_id"], :name => "index_my_digis_my_games_on_my_game_id_and_my_digi_id", :unique => true

  create_table "my_games", :force => true do |t|
    t.integer  "game_id"
    t.string   "title"
    t.string   "author"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "assessment_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "correct"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequences", :force => true do |t|
    t.integer  "custom_event_id"
    t.integer  "my_digi_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "login"
    t.string   "school"
    t.string   "state"
    t.string   "grades"
    t.string   "mgmt"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "grade6"
    t.boolean  "grade7"
    t.boolean  "grade8"
    t.boolean  "grade9"
    t.boolean  "grade10"
    t.boolean  "grade11"
    t.boolean  "grade12"
    t.boolean  "university"
    t.boolean  "other"
  end

  create_table "traffics", :force => true do |t|
    t.string   "ip"
    t.integer  "score"
    t.datetime "time"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referrer",   :default => ""
    t.integer  "didji",      :default => 0
    t.string   "city",       :default => "unknown"
    t.string   "domain",     :default => "unknown"
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
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.boolean  "admin",                                    :default => false,     :null => false
    t.boolean  "subscribed"
    t.boolean  "teacher"
    t.boolean  "author"
    t.integer  "invite_id"
    t.integer  "invitation_limit",                         :default => 5
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
