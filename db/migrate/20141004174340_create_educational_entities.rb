class CreateEducationalEntities < ActiveRecord::Migration
  def change
    enable_extension :hstore
    create_table :educational_entities do |t|

      t.string   :name, null: false
      t.string   :native_name
      t.string   :acronym
      t.integer  :founded_in, null: false
      t.string   :motto
      t.string   :native_motto
      t.string   :website_url, null: false
      t.string   :colors

      # ADDRESS INFO
      t.string   :town, null: false
      t.string   :zipcode
      t.string   :state_or_provinance
      t.string   :country, null: false
      t.string   :continent, null: false

      # CONTACT INFO
      t.string   :phone_number
      t.string   :fax_number
      t.json     :address, null: false
      t.json     :admission_office_address

      # PROFILE INFO
      t.string   :entity_type, null: false   # profit or non profit
      t.string   :control_type, null: false  # public or private
      # degree college affiliated with a univ
      # polytechnic college# open university # Deemed university
      # university # autonomous institute
      # polytechnic college can also come under a university
      t.string   :institute_type, null: false
      t.integer  :university_id
      t.string   :student_enrollment_range
      t.string   :faculty_staff_range
      t.string   :gender
      t.boolean  :international_students
      t.string   :selection_criteria
      t.string   :selection_percentage
      t.boolean  :financial_aid_or_scholership
      t.boolean  :distance_or_online_course
      t.string   :academic_calender_system
      t.string   :religious_affiliation
      t.json     :fees_info


      # COURSES INFO
      # "0" => "All Courses",
      # "2" => "Arts & Humanities",
      # "3" => "Business & Social Sciences",
      # "4" => "Language & Cultural",
      # "5" => "Medicine & Health",
      # "6" => "Engineering",
      # "7" => "Science & Technology"
      t.integer  :all_courses_info                    , array: true
      t.integer  :art_humanities_courses_info         , array: true
      t.integer  :business_social_science_courses_info, array: true
      t.integer  :medicine_health_courses_info        , array: true
      t.integer  :engineering_courses_info            , array: true
      t.integer  :science_tech_courses_info           , array: true

      t.string   :structure_info, array: true
      t.string   :affiliations  , array: true
      t.json :accreditation__info, default: {
                                                year_of_first_accreditation: "NA",
                                                institutional_recognition: "NA"

                                              }

      t.hstore  :social_links, :default => {
                                              facebook:         "NA",
                                              twitter:          "NA",
                                              linkedin:         "NA",
                                              youtube:          "NA",
                                              flickr:           "NA",
                                              itunes:           "NA",
                                              open_courseware:  "NA",
                                              wikipedia:        "NA"
                                          }









      t.timestamps null: false
    end

  end
end
