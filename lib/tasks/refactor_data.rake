namespace :refactor_data do
  desc "put data from api_responses table"

  task :data_from_4icu, [:user_id] => [:environment] do |t, args|
    ApiResponse.order("id").where(success: true).where("id >= 417").each do |arp|
      puts "==========>processing api_response id : #{arp.id}"
      ar = JSON.parse arp.response

      ed_en = EducationalEntity.new

      ed_en.name        = ar["general_info"]["University Name"].to_s
      ed_en.native_name = ar["general_info"]["University Name_alt"].to_s
      ed_en.acronym     = ar["general_info"]["Acronym"].to_s
      ed_en.founded_in  = ar["general_info"]["Established in"].to_s
      ed_en.motto       = ar["general_info"]["Motto"].to_s
      ed_en.website_url = ar["web_info"]["website_url"].to_s
      ed_en.colors      = ar["general_info"]["Colours"].to_s
      puts ":::::::::GENERAL INFO"

      ed_en.street_or_area      = ar["location_info"]["Address"][0].to_s
      ed_en.town                = ar["location_info"]["Address"][1].to_s
      ed_en.zipcode             = ar["location_info"]["Address"][2].to_s
      ed_en.state_or_provinance =
      ed_en.country             = ar["location_info"]["country"].to_s
      ed_en.continent           = ar["location_info"]["continent"].to_s
      puts ":::::::::ADDRESS INFO"


      ed_en.phone_number             = ar["location_info"]["Phone"][2].to_s
      ed_en.fax_number               = ar["location_info"]["Fax"][2].to_s
      ed_en.address                  = ar["location_info"]["Address"]
      ed_en.admission_office_address = ar["admission_info"]["Admission Office"].to_s
      puts ":::::::::CONTACT INFO"

      ed_en.profit_level                 = ar["size_info"]["Entity Type"].to_s
      ed_en.control_type                 = ar["size_info"]["Control Type"].to_s
      ed_en.institute_level              = "University"
      ed_en.university_id                = nil
      ed_en.student_enrollment_range     = ar["size_info"]["Student Enrollment Range"].to_s
      ed_en.faculty_staff_range          = ar["size_info"]["Academic Staff Range"].to_s
      ed_en.gender                       = ar["admission_info"]["Gender Admission"].to_s
      ed_en.international_students       = ar["admission_info"]["International Students"].to_s
      ed_en.selection_criteria           = ar["admission_info"]["Admission Selection"].to_s
      ed_en.selection_percentage         = ar["admission_info"]["Selection Percentage"].to_s
      ed_en.financial_aid_or_scholership = ar["amneties_info"][" Financial Aids / Scholarships"].to_s
      ed_en.distance_or_online_course    = ar["amneties_info"]["Study Abroad / Exchange Programs"]
      ed_en.academic_calender_system     = ar["size_info"]["Academic Calendar"].to_s
      ed_en.religious_affiliation        = ar["size_info"]["Religious Affiliation"].to_s
      ed_en.fees_info                    = ar["tution_info"]
      puts ":::::::::PROFILE INFO"

      ed_en.all_courses_info                     = ar["courses_info"]["All Courses"]
      ed_en.art_humanities_courses_info          = ar["courses_info"]["Arts & Humanities"]
      ed_en.business_social_science_courses_info = ar["courses_info"]["Business & Social Sciences"]
      ed_en.language_and_cultural_courses_info   = ar["courses_info"]["Language & Cultural"]
      ed_en.medicine_health_courses_info         = ar["courses_info"]["Medicine & Health"]
      ed_en.engineering_courses_info             = ar["courses_info"]["Engineering"]
      ed_en.science_tech_courses_info            = ar["courses_info"]["Science & Technology"]
      puts ":::::::::COURSES INFO"

      ed_en.structure_info     = ar["structure_info"]
      ed_en.affiliations       = ar["affiliation_info"]
      ed_en.accreditation_info = ar["accreditation_info"]
      ed_en.social_links       = ar["social_links"]
      puts ":::::::::OTHER INFO"

      ed_en.amneties = {
                          library:                ar["amneties_info"]["Library"],
                          sports_facility:        ar["amneties_info"]["Sport Facilities and Activities"],
                          accomodation_hostel:    ar["amneties_info"]["Housing"],
                          swimming_pool:          nil,
                          recreation_center:      nil,
                          gymnasium:              nil,
                          bank_and_atm:           nil,
                          courier_facility:       nil,
                          girls_hostel:           nil,
                          broadband_connectivity: nil,
                          medical_clinic:         nil

                        }
      puts ":::::::::AMNETIES INFO"

      ed_en.save!

      puts "educational entity published for api_response id : #{arp.id}"
    end
  end
end