# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121006024548) do

  create_table "members", :force => true do |t|
    t.string   "member_name",   :null => false
    t.boolean  "member_gender", :null => false
    t.integer  "rank_id",       :null => false
    t.integer  "grade",         :null => false
    t.integer  "type_id"
    t.integer  "pair_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "members", ["member_name"], :name => "index_members_on_member_name", :unique => true

  create_table "pairs", :force => true do |t|
    t.string   "pair_name",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pairs", ["pair_name"], :name => "index_pairs_on_pair_name", :unique => true

  create_table "ranks", :force => true do |t|
    t.string   "rank_name",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ranks", ["rank_name"], :name => "index_ranks_on_rank_name", :unique => true

  create_table "types", :force => true do |t|
    t.string   "type_name",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "types", ["type_name"], :name => "index_types_on_type_name", :unique => true

end
