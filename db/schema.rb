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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141004174340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "api_responses", force: true do |t|
    t.string   "url",           null: false
    t.text     "response"
    t.text     "error_message"
    t.boolean  "success"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "educational_entities", force: true do |t|
    t.string   "name",                                                                                                                                                                                      null: false
    t.string   "native_name"
    t.string   "acronym"
    t.integer  "founded_in",                                                                                                                                                                                null: false
    t.string   "motto"
    t.string   "native_motto"
    t.string   "website_url",                                                                                                                                                                               null: false
    t.string   "colors"
    t.string   "address",                                                                                                                                                                                   null: false
    t.string   "town",                                                                                                                                                                                      null: false
    t.string   "state_or_provinance"
    t.string   "country",                                                                                                                                                                                   null: false
    t.string   "continent",                                                                                                                                                                                 null: false
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "entity_type",                                                                                                                                                                               null: false
    t.string   "control_type",                                                                                                                                                                              null: false
    t.string   "institute_type",                                                                                                                                                                            null: false
    t.string   "student_enrollment_range"
    t.string   "faculty_staff_range"
    t.integer  "university_id"
    t.string   "gender"
    t.boolean  "international_students"
    t.string   "selection_criteria"
    t.string   "selection_percentage"
    t.boolean  "financial_aid_or_scholership"
    t.boolean  "distance_or_online_course"
    t.string   "academic_calender_system"
    t.string   "religious_affiliation"
    t.string   "admission_office_address"
    t.hstore   "fees_info",                    default: {"pg_local"=>"Not Reported", "ug_local"=>"Not Reported", "pg_international"=>"Not Reported", "ug_international"=>"Not Reported"}
    t.hstore   "social_links",                 default: {"flickr"=>"NA", "itunes"=>"NA", "twitter"=>"NA", "youtube"=>"NA", "facebook"=>"NA", "linkedin"=>"NA", "wikipedia"=>"NA", "open_courseware"=>"NA"}
    t.text     "structure_info"
    t.hstore   "accreditation__info",          default: {"institutional_recognition"=>"NA", "year_of_first_accreditation"=>"NA"}
    t.text     "affiliation_info"
    t.datetime "created_at",                                                                                                                                                                                null: false
    t.datetime "updated_at",                                                                                                                                                                                null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
