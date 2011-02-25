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

ActiveRecord::Schema.define(:version => 20110223144432) do

# Could not dump table "accounts" because of following Mysql2::Error
#   Invalid date: BTREE
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
end
