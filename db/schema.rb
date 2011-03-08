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

ActiveRecord::Schema.define(:version => 20110308120926) do

# Could not dump table "accounts" because of following ArgumentError
#   invalid date

# Could not dump table "bonus_rounds" because of following ArgumentError
#   invalid date

# Could not dump table "custom_events" because of following ArgumentError
#   invalid date

  create_table "custom_events_my_digis", :id => false, :force => true do |t|
    t.integer "my_digi_id",      :null => false
    t.integer "custom_event_id", :null => false
  end

# Could not dump table "event_sequences" because of following ArgumentError
#   invalid date

# Could not dump table "event_suggestions" because of following ArgumentError
#   invalid date

# Could not dump table "events" because of following ArgumentError
#   invalid date

# Could not dump table "game_builds" because of following ArgumentError
#   invalid date

# Could not dump table "game_levels" because of following ArgumentError
#   invalid date

# Could not dump table "game_stats" because of following ArgumentError
#   invalid date

# Could not dump table "invites" because of following ArgumentError
#   invalid date

# Could not dump table "jenbs" because of following ArgumentError
#   invalid date

# Could not dump table "mchoices" because of following ArgumentError
#   invalid date

# Could not dump table "my_digis" because of following ArgumentError
#   invalid date

# Could not dump table "my_digis_my_games" because of following ArgumentError
#   invalid date

# Could not dump table "my_games" because of following ArgumentError
#   invalid date

# Could not dump table "players" because of following ArgumentError
#   invalid date

# Could not dump table "roles" because of following ArgumentError
#   invalid date

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "sequences" because of following ArgumentError
#   invalid date

# Could not dump table "surveys" because of following ArgumentError
#   invalid date

# Could not dump table "traffics" because of following ArgumentError
#   invalid date

# Could not dump table "users" because of following ArgumentError
#   invalid date

end
