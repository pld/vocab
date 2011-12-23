# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 4) do

  create_table "languages", :force => true do |t|
    t.string "language"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "words", :force => true do |t|
    t.string   "word",                     :null => false
    t.integer  "known",       :limit => 1, :null => false
    t.string   "definition1",              :null => false
    t.string   "definition2"
    t.string   "definition3"
    t.string   "definition4"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "priority"
    t.integer  "language_id"
  end

end
