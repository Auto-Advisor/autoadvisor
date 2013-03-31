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

ActiveRecord::Schema.define(:version => 20130331021405) do

  create_table "credit_constraints", :force => true do |t|
    t.string   "field"
    t.string   "op"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "credits", :force => true do |t|
    t.string  "name"
    t.string  "year"
    t.float   "grade"
    t.string  "dept"
    t.string  "number"
    t.integer "user_id"
  end

  create_table "majors", :force => true do |t|
    t.string "name"
    t.string "degree"
    t.string "dept"
  end

  create_table "majors_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "major_id"
  end

  add_index "majors_users", ["major_id", "user_id"], :name => "index_majors_users_on_major_id_and_user_id"
  add_index "majors_users", ["user_id", "major_id"], :name => "index_majors_users_on_user_id_and_major_id"

  create_table "sections", :force => true do |t|
    t.integer "spire_id"
    t.string  "dept",                            :null => false
    t.integer "class_number",   :default => 0,   :null => false
    t.string  "class_string",                    :null => false
    t.string  "section_number",                  :null => false
    t.string  "instructor"
    t.integer "size"
    t.string  "name"
    t.text    "desc"
    t.integer "time_slot_id"
    t.string  "room"
    t.string  "units",          :default => "0", :null => false
    t.string  "type",           :default => "",  :null => false
  end

  create_table "time_slots", :force => true do |t|
    t.string  "days"
    t.integer "beg_min"
    t.integer "beg_hour"
    t.integer "end_min"
    t.integer "end_hour"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "admin"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
