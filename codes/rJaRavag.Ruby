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

ActiveRecord::Schema.define(:version => 20100520192112) do

  create_table "batches", :force => true do |t|
    t.string   "filename"
    t.string   "protocol"
    t.datetime "start"
    t.datetime "end"
    t.string   "device"
    t.string   "user"
    t.string   "comment"
    t.string   "platetype"
    t.string   "lot"
    t.string   "mtp_rows"
    t.string   "mtp_columns"
    t.text     "channels"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "experiment_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conditions", :force => true do |t|
    t.string   "value"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conditions_experiments", :id => false, :force => true do |t|
    t.integer "condition_id"
    t.integer "experiment_id"
  end

  create_table "experiments", :force => true do |t|
    t.integer  "batch_id"
    t.string   "placement"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "measurements_count", :default => 0
    t.text     "overview"
    t.integer  "last_edited_by"
  end

  create_table "experiments_sources", :id => false, :force => true do |t|
    t.integer "experiment_id"
    t.integer "source_id"
  end

  create_table "experiments_studies", :id => false, :force => true do |t|
    t.integer "experiment_id"
    t.integer "study_id"
  end

  create_table "measurements", :force => true do |t|
    t.text     "description"
    t.integer  "experiment_id"
    t.float    "time"
    t.float    "measure"
    t.integer  "cycle"
    t.float    "treatment"
    t.integer  "interval"
    t.string   "channel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "value"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end