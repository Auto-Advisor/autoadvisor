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

ActiveRecord::Schema.define(:version => 20130429172656) do

  create_table "courses", :force => true do |t|
    t.text    "desc"
    t.string  "name",     :default => "Unknown", :null => false
    t.integer "number",   :default => 0,         :null => false
    t.string  "string",   :default => "UNKNOWN", :null => false
    t.boolean "hidden",   :default => false,     :null => false
    t.string  "dept",     :default => "",        :null => false
    t.integer "major_id"
  end

  create_table "credits", :force => true do |t|
    t.string  "year"
    t.string  "grade"
    t.integer "user_id"
    t.integer "course_id",                               :default => 0,   :null => false
    t.decimal "units",     :precision => 8, :scale => 4, :default => 0.0, :null => false
    t.decimal "points",    :precision => 8, :scale => 4, :default => 0.0, :null => false
  end

  create_table "credits_users", :force => true do |t|
    t.integer "credit_id"
    t.integer "user_id"
  end

  add_index "credits_users", ["credit_id", "user_id"], :name => "index_credits_users_on_credit_id_and_user_id"
  add_index "credits_users", ["user_id", "credit_id"], :name => "index_credits_users_on_user_id_and_credit_id"

  create_table "majors", :force => true do |t|
    t.string "name"
    t.string "degree"
    t.string "dept"
    t.string "code",   :default => "", :null => false
  end

  create_table "majors_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "major_id"
  end

  add_index "majors_users", ["major_id", "user_id"], :name => "index_majors_users_on_major_id_and_user_id"
  add_index "majors_users", ["user_id", "major_id"], :name => "index_majors_users_on_user_id_and_major_id"

  create_table "schedules", :force => true do |t|
    t.text     "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedules_sections", :id => false, :force => true do |t|
    t.integer "schedule_id"
    t.integer "section_id"
  end

  add_index "schedules_sections", ["schedule_id", "section_id"], :name => "index_schedules_sections_on_schedule_id_and_section_id"
  add_index "schedules_sections", ["section_id", "schedule_id"], :name => "index_schedules_sections_on_section_id_and_schedule_id"

  create_table "sections", :force => true do |t|
    t.integer "spire_id"
    t.string  "section_number",                 :null => false
    t.string  "instructor"
    t.integer "size"
    t.string  "room"
    t.string  "ty",             :default => "", :null => false
    t.integer "course_id",      :default => 0,  :null => false
    t.string  "days",           :default => "", :null => false
    t.string  "gened",          :default => "", :null => false
    t.integer "min_start",      :default => 0,  :null => false
    t.integer "min_end",        :default => 0,  :null => false
    t.integer "credit_min",     :default => 0,  :null => false
    t.integer "credit_max",     :default => 0,  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                :default => "",  :null => false
    t.string   "encrypted_password",                                   :default => "",  :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.boolean  "admin"
    t.decimal  "gpa",                    :precision => 8, :scale => 4, :default => 0.0, :null => false
    t.decimal  "grade_points",           :precision => 8, :scale => 4, :default => 0.0, :null => false
    t.decimal  "credit_hours",           :precision => 8, :scale => 4, :default => 0.0, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
