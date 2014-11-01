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

ActiveRecord::Schema.define(version: 20141101090538) do

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

  create_table "authorizations", force: true do |t|
    t.string   "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "image_url"
    t.string   "token"
    t.string   "secret"
    t.json     "oauth_response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educational_entities", force: true do |t|
    t.string   "name",                                                                                                                                                                                                                                                                                                             null: false
    t.string   "native_name"
    t.string   "acronym"
    t.integer  "founded_in",                                                                                                                                                                                                                                                                                                       null: false
    t.string   "motto"
    t.string   "native_motto"
    t.string   "website_url",                                                                                                                                                                                                                                                                                                      null: false
    t.string   "colors"
    t.string   "street_or_area"
    t.string   "town",                                                                                                                                                                                                                                                                                                             null: false
    t.string   "zipcode"
    t.string   "state_or_provinance"
    t.string   "country",                                                                                                                                                                                                                                                                                                          null: false
    t.string   "continent",                                                                                                                                                                                                                                                                                                        null: false
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "address",                                                                                                                                                                                                                                                                                                          null: false, array: true
    t.string   "admission_office_address"
    t.string   "profit_level",                                                                                                                                                                                                                                                                                                     null: false
    t.string   "control_type",                                                                                                                                                                                                                                                                                                     null: false
    t.string   "institute_level",                                                                                                                                                                                                                                                                                                  null: false
    t.integer  "university_id"
    t.string   "student_enrollment_range"
    t.string   "faculty_staff_range"
    t.string   "gender"
    t.boolean  "international_students"
    t.string   "selection_criteria"
    t.string   "selection_percentage"
    t.boolean  "financial_aid_or_scholership"
    t.boolean  "distance_or_online_course"
    t.string   "academic_calender_system"
    t.string   "religious_affiliation"
    t.json     "fees_info"
    t.boolean  "all_courses_info",                                                                                                                                                                                                                                                                                                              array: true
    t.boolean  "art_humanities_courses_info",                                                                                                                                                                                                                                                                                                   array: true
    t.boolean  "business_social_science_courses_info",                                                                                                                                                                                                                                                                                          array: true
    t.boolean  "language_and_cultural_courses_info",                                                                                                                                                                                                                                                                                            array: true
    t.boolean  "medicine_health_courses_info",                                                                                                                                                                                                                                                                                                  array: true
    t.boolean  "engineering_courses_info",                                                                                                                                                                                                                                                                                                      array: true
    t.boolean  "science_tech_courses_info",                                                                                                                                                                                                                                                                                                     array: true
    t.string   "structure_info",                                                                                                                                                                                                                                                                                                                array: true
    t.string   "affiliations",                                                                                                                                                                                                                                                                                                                  array: true
    t.json     "accreditation_info",                   default: {"year_of_first_accreditation"=>"NA", "institutional_recognition"=>"NA"}
    t.hstore   "social_links",                         default: {"flickr"=>"NA", "itunes"=>"NA", "twitter"=>"NA", "youtube"=>"NA", "facebook"=>"NA", "linkedin"=>"NA", "wikipedia"=>"NA", "open_courseware"=>"NA"}
    t.json     "amneties",                             default: {"library"=>true, "sports_facility"=>true, "accomodation_hostel"=>nil, "swimming_pool"=>nil, "recreation_center"=>nil, "gymnasium"=>nil, "bank_and_atm"=>nil, "courier_facility"=>nil, "girls_hostel"=>nil, "broadband_connectivity"=>nil, "medical_clinic"=>nil}
    t.datetime "created_at",                                                                                                                                                                                                                                                                                                       null: false
    t.datetime "updated_at",                                                                                                                                                                                                                                                                                                       null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
