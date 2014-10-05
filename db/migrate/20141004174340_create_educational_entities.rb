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
      t.string   :street_or_area
      t.string   :town, null: false
      t.string   :zipcode
      t.string   :state_or_provinance
      t.string   :country, null: false
      t.string   :continent, null: false

      # CONTACT INFO
      t.string   :phone_number
      t.string   :fax_number
      t.string   :address, null: false, array: true
      t.string   :admission_office_address

      # PROFILE INFO
      t.string   :profit_level, null: false   # profit or non profit
      t.string   :control_type, null: false  # public or private
      # degree college affiliated with a univ
      # polytechnic college# open university # Deemed university
      # university # autonomous institute
      # polytechnic college can also come under a university
      t.string   :institute_level, null: false
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
      t.boolean  :all_courses_info                    , array: true
      t.boolean  :art_humanities_courses_info         , array: true
      t.boolean  :business_social_science_courses_info, array: true
      t.boolean  :language_and_cultural_courses_info  , array: true
      t.boolean  :medicine_health_courses_info        , array: true
      t.boolean  :engineering_courses_info            , array: true
      t.boolean  :science_tech_courses_info           , array: true

      t.string   :structure_info, array: true
      t.string   :affiliations  , array: true
      t.json :accreditation_info, default: {
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


      t.json    :amneties, default: {
                                      library:                true,
                                      sports_facility:        true,
                                      accomodation_hostel:    nil,
                                      swimming_pool:          nil,
                                      recreation_center:      nil,
                                      gymnasium:              nil,
                                      bank_and_atm:           nil,
                                      courier_facility:       nil,
                                      girls_hostel:           nil,
                                      broadband_connectivity: nil,
                                      medical_clinic:         nil

                                    }









      t.timestamps null: false
    end

  end
end
