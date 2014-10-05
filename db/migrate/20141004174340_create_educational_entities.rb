class CreateEducationalEntities < ActiveRecord::Migration
  def change
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
      t.string   :address, null: false
      t.string   :town, null: false
      t.string   :state_or_provinance
      t.string   :country, null: false
      t.string   :continent, null: false

      # CONTACT INFO
      t.string   :phone_number
      t.string   :fax_number

      # PROFILE INFO
      t.string   :entity_type, null: false   # profit or non profit
      t.string   :control_type, null: false  # public or private
      # degree college affiliated with a univ
      # polytechnic college
      # open university
      # Deemed university
      # university
      # autonomous institute

      #polytechnic college can also come under a university
      t.string  :institute_type, null: false
      t.string  :student_enrollment_range
      t.string  :faculty_staff_range
      t.integer :university_id

      t.string  :gender
      t.boolean :international_students
      t.string  :selection_criteria
      t.string  :selection_percentage
      t.boolean :financial_aid_or_scholership
      t.boolean :distance_or_online_course
      t.string  :academic_calender_system
      t.string  :religious_affiliation
      t.string  :admission_office_address

      t.hstore  :fees_info,  :default => {
                                            ug_local:         "Not Reported",
                                            ug_international: "Not Reported",
                                            pg_local:         "Not Reported",
                                            pg_international: "Not Reported"
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
      t.text   :structure_info
      t.hstore :accreditation__info, default: {
                                                year_of_first_accreditation: "NA",
                                                institutional_recognition: "NA"

                                              }
      t.text   :affiliation_info








      t.timestamps null: false
    end

  end
end
