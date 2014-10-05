namespace :refactor_data do
  desc "put data from api_responses table"

  task :data_from_4icu, [:user_id] => [:environment] do |t, args|
    ApiResponse.where("id < 10").each do |ar|
      ar = JSON.parse ar.response

      ed_en = EducationalEntity.new

      ed_en.name        = ar["general_info"]["University Name"]
      ed_en.native_name        = ar["general_info"]["University Name_alt"]
      ed_en.acronym     = ar["general_info"]["Acronym"]
      ed_en.founded_in  = ar["general_info"]["Established in"]
      ed_en.motto       = ar["general_info"]["Motto"]
      ed_en.website_url = ar["web_info"]["website_url"]
      ed_en.colors      = ar["general_info"]["Colours"]

      ed_en.street_or_area      = ar["location_info"]["Address"][0]
      ed_en.town                = ar["location_info"]["Address"][1]
      ed_en.zipcode             = ar["location_info"]["Address"][2]
      ed_en.state_or_provinance =
      ed_en.country             = ar["location_info"]["country"]
      ed_en.continent           = ar["location_info"]["continent"]


      ed_en.phone_number             = ar["location_info"]["Phone"][2]
      ed_en.fax_number               = ar["location_info"]["Fax"][2]
      ed_en.address                  = ar["location_info"]["Address"]
      ed_en.admission_office_address = ar["admission_info"]["Admission Office"]

      ed_en.profit_level                 = ar["size_info"]["Entity Type"]
      ed_en.control_type                 = ar["size_info"]["Control Type"]
      ed_en.institute_level              = "University"
      ed_en.university_id                = nil
      ed_en.student_enrollment_range     = ar["size_info"]["Student Enrollment Range"]
      ed_en.faculty_staff_range          = ar["size_info"]["Academic Staff Range"]
      ed_en.gender                       = ar["admission_info"]["Gender Admission"]
      ed_en.international_students       = ar["admission_info"]["International Students"]
      ed_en.selection_criteria           = ar["admission_info"]["Admission Selection"]
      ed_en.selection_percentage         = ar["admission_info"]["Selection Percentage"]
      ed_en.financial_aid_or_scholership = ar["amneties_info"][" Financial Aids / Scholarships"]
      ed_en.distance_or_online_course    = ar["amneties_info"]["Study Abroad / Exchange Programs"]
      ed_en.academic_calender_system     = ar["size_info"]["Academic Calendar"]
      ed_en.religious_affiliation        = ar["size_info"]["Religious Affiliation"]
      ed_en.fees_info                    = ar["tution_info"]

      ed_en.all_courses_info                     = ar["courses_info"]["All Courses"]
      ed_en.art_humanities_courses_info          = ar["courses_info"]["Arts & Humanities"]
      ed_en.business_social_science_courses_info = ar["courses_info"]["Business & Social Sciences"]
      ed_en.language_and_cultural_courses_info   = ar["courses_info"]["Language & Cultural"]
      ed_en.medicine_health_courses_info         = ar["courses_info"]["Medicine & Health"]
      ed_en.engineering_courses_info             = ar["courses_info"]["Engineering"]
      ed_en.science_tech_courses_info            = ar["courses_info"]["Science & Technology"]

      ed_en.structure_info     = ar["structure_info"]
      ed_en.affiliations       = ar["affiliation_info"]
      ed_en.accreditation_info = ar["accreditation_info"]
      ed_en.social_links       = ar["social_links"]

      ed_en.save!
    end
  end
end