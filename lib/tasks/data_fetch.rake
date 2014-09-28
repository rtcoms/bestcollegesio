require 'open-uri'
require 'mechanize'
require 'nokogiri'

namespace :data_fetch do
  desc "Fetching college data from internet"
  task :from_4icu, [:user_id] => [:environment] do |t, args|
      puts "THIS IS SPARTA"

      COURSE_PROVIDED ={
        "0" => "All Courses",
        "2" => "Arts & Humanities",
        "3" => "Business & Social Sciences",
        "4" => "Language & Cultural",
        "5" => "Medicine & Health",
        "6" => "Engineering",
        "7" => "Science & Technology"
      }
      #USING MECHANIZE
      # agent = Mechanize.new
      # agent.user_agent = 'Individueller User-Agent'
      # agent.user_agent_alias = 'Linux Mozilla'
      # doc = agent.get("http://www.4icu.org/reviews/1978.htm")
      # puts web_title = agent.page.title
      # html = agent.page.content
      # puts agent.get("http://www.4icu.org/reviews/1978.htm").search(".//a")

      #USING NOKOGIRI
      # page = Nokogiri::HTML(open("http://www.4icu.org/reviews/1978.htm"))
      # page.class   # => Nokogiri::HTML::Document
      # page.encoding = 'UTF-8'
      # puts page.css("a")[13].text
      # puts page.css("a")[13]["href"]
      # puts page.css("a")[14].text

      #6077

      page = Nokogiri::HTML(open("http://www.4icu.org/reviews/6077.htm"))
      page.encoding = 'UTF-8'

      college_info = {}
      college_info.compare_by_identity
      puts "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG"
      #general info columns
      # university_name, name_in_english, acronym, website, email, year of establish, motto
      # motto in english, colours, mascot
      college_info[:general_info] = {}
      #TABLE 4 element is GENERAL UNIVERSITY INFO
      page.css("table")[4].css("tr").each do |x|
        #event numbers is for key(field_name) -- odd number is value for field name
        tds = x.css("td")

        info_column_name =  tds[0].css("h4").text.strip
        info_column_value =  tds[1].css("h5").text.strip

        if college_info[:general_info][info_column_name].nil?
          college_info[:general_info][info_column_name] = info_column_value
        else
          info_column_name = info_column_name + '_alt'
          college_info[:general_info][info_column_name] = info_column_value
        end
      end
      puts "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG"
      puts "\n"

      puts  "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
      #college website url
      web_url = page.css("table")[4].css("tr").css("td").css("a")[0]["href"]
      college_info[:web_info] = {
          "website_url" => web_url
        }
      puts "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
      puts "\n"

      puts "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
      college_info[:location_info] = {}
      #location info columns
      # Address, town, town size, other towns, post code, state or provinance, country, phone,
      # fax

      page.css("table")[5].css("tr").each do |x|

        tds = x.css("td")

        info_column_name_text =  tds[0].css("h4").text.strip
        info_column_image     =  tds[0].css("img").attr('src') if !x.css("img").blank?
        info_column_value     =  tds[1].css("h5").map{|x| x.text.strip }.join(",")

        if info_column_name_text.blank? && info_column_image.present?
          info_column_name_text = "Phone" if info_column_image.to_s.match("telephone")
          info_column_name_text = "Fax" if info_column_image.to_s.match("telefax")
        end


        if college_info[:location_info][info_column_name_text].nil?
          college_info[:location_info][info_column_name_text] = info_column_value
        else
          info_column_name_text = info_column_name_text + '_alt'
          college_info[:location_info][info_column_name_text] = info_column_value
        end
      end
      puts "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
      #puts page.css("table")[6].css("tr")

      college_info[:courses_info] = {}
      puts "CACACACACACACACACACACACACACACACACACACACCACACACA"
      page.css("table")[6].css("tr").each_with_index do |x, index|
        next if index < 3 || index == 4
         details_index = index - 3
         x.css("td").map{|x|
          (x.css("img").attr('src').to_s.match("1.gif") || x.css("img").attr('src').to_s.match("1b.gif")).present? if !x.css("img").blank?
         }.compact.flatten.each_slice(5).with_index do |*details, i|
          college_info[:courses_info][COURSE_PROVIDED[details_index.to_s]] = details
         end
      end

      puts "CACACACACACACACACACACACACACACACACACACACCACACACA"

      puts "TUTION INFO FETCHING"
      college_info[:tution_info] = {}
      page.css("table")[7].css("tr").each_with_index do |x, index|
        next if index == 0 || index == 3
        tds = x.css("td")
        info_column_name_text =  tds[0].css("h5").text.strip
        ug_fees = tds[1].css("h6").text.strip
        pg_fees = tds[2].css("h6").text.strip

        college_info[:tution_info][info_column_name_text] = {
          :ug_fees => ug_fees,
          :pg_fees => pg_fees
        }
      end
      puts "TUTION INFO FETCHED"

      puts "fetching ADMINSSION INFO"
      college_info[:admission_info] = {}
      info_elements = page.css(".section")[14].css("h4")
      info_elements.to_a.each do |e|
        reference_element =  e
        value_element = reference_element.next_element
        info_column_name =  e.text
        info_column_value =   if value_element.name == "h5"
                                value_element.text.strip
                              else
                                value_element.css("img").attr('src').to_s.match("1.gif").present?
                              end
        college_info[:admission_info][info_column_name] = info_column_value
      end
      puts "fetched ADMINSSION INFO"




      puts "fetching size and profile INFO"
      college_info[:size_info] = {}
      info_elements = page.css(".section")[17].css("h4")
      info_elements.to_a.each do |e|
        reference_element =  e
        value_element = reference_element.next_element
        info_column_name =  e.text
        info_column_value =   if value_element.name == "h5"
                                value_element.text.strip
                              else
                                value_element.css("img").attr('src').to_s.match("1.gif").present?
                              end
        college_info[:size_info][info_column_name] = info_column_value
      end
      puts "fetched size and profile INFO"




      college_info[:amneties_info] = {}
      puts "fetching facilities and services"
      info_elements = page.css(".section")[19].css("h4")
      info_elements.to_a.each do |e|
        reference_element =  e
        value_element = reference_element.next_element
        info_column_name =  e.text
        info_column_value =   if value_element.name == "h5"
                                value_element.text.strip
                              else
                                value_element.css("img").attr('src').to_s.match("1.gif").present?
                              end
        college_info[:amneties_info][info_column_name] = info_column_value
      end

      puts "fetched facilities and services"


      college_info[:accreditation_info] = {}
      puts "fetching accreditation info"
      info_elements = page.css(".section")[22].css("h4")
      info_elements.to_a.each do |e|
        reference_element =  e
        value_element = reference_element.next_element
        info_column_name =  e.text
        info_column_value =   if value_element.name == "h5"
                                value_element.text.strip
                              elsif value_element.name == "ul"
                                value_element.css("li").map{|x| x.text.strip}.join(",")
                              else
                                value_element.css("img").attr('src').to_s.match("1.gif").present?
                              end
        college_info[:accreditation_info][info_column_name] = info_column_value
      end
      puts "fetched accreditation info"


      college_info[:structure_info] = {}
      puts "fetching academic structure info"
      info_column_value = page.css(".section")[24].css("h5").css("ul").css("li").map{|x| x.text.strip}.join("|||")
      college_info[:structure_info] = info_column_value
      puts "fetched academic structure info"


      college_info[:affiliation_info] = {}
      puts "fetching affiliation and membership info info"
      info_column_value = page.css(".section")[26].css("h5").css("ul").css("li").map{|x| x.text.strip}.join("|||")
      college_info[:affiliation_info] = info_column_value
      puts "fetched affiliation and membership info"

      college_info[:social_links] = {}
      puts "fetching social links info"
      info_elements = page.css(".section")[28].css("h4")
      info_elements.to_a.each do |e|
        reference_element =  e
        value_element = reference_element.next_element
        info_column_name =  e.text
        info_column_value =   if value_element.name == "h5"
                                value_element.text.strip
                              elsif value_element.name == "a"
                                value_element.attr('href').to_s
                              elsif value_element.name == "ul"
                                value_element.css("li").map{|x| x.text.strip}.join(",")
                              else
                                value_element.css("img").attr('src').to_s.match("1.gif").present?
                              end
        college_info[:social_links][info_column_name] = info_column_value
      end
      puts "fetched social links info"


      puts college_info






      #STRUCTURING AREAS OF STUDY
      #in database store like
      # Arts - Literature
      # Humanities - Philosophy
      # SocialScience - Sociology
      ART_AND_HUMANITIES_AND_SOCIAL_SCIENCE = [
        "History",
        "Linguistics",
        "Literature",
        "Visula Arts",
        "Applied Arts",
        "Performing arts/ Fine Arts",
        "Philosophy",
        "Religion and Theology",
        "Anthropology / Archaeology",
        "Area studies",
        "Cultural and ethnic studies",
        "Economics",
        "Gender and sexuality studies",
        "Geography",
        "Political and International science",
        "Sociology / Psychology",
        "Physical Education/ Sports Science",
        "Social Work",
        "Social Policy/ Public Administration",
        "Library and Information Science",
        "Social Work",
        "Others"
      ]

      #in database store like
      #Business -
      #commerce -
      #management -

      BUSINESS_COMMERCE_MANAGEMENT = [
        "Tourism / Hospitality",
        "Business administration",
        "Accounting / Finance",
        "Human resources",
        "Marketing",
        "Information systems",
        "International trade",
        "Information Technology",
        "Legal Studies",
        "Operation Management",
        "Project Management",
        "Supply Chain",
        "Commerce",
        "Others"
      ]

      JOURNALISM_COMMUNICATION_AND_MASS_MEDIA_STUDIES = [
        #journalism
        "Literary journalism",
        "Print journalism",
        "Sports journalism / sportscasting",
        #mass media studies
        "Newspaper",
        "Magazine",
        "Radio",
        "Television",
        "Internet",
        #communication studies
        "Advertising",
        "Communication design",
        "Environmental communication",
        "Information theory",
        "Intercultural communication",
        "Marketing",
        "Mass communication",
        "Nonverbal communication",
        "Organizational communication",
        "Propaganda",
        "Public relations",
        "Speech communication",
        "Technical writing",
        "Translation"


      ]

      EDUCATION = [
        "Alternative education"
        "Elementary education"
        "Secondary education"
        "Higher education"
        "Mastery learning"
        "Cooperative learning"
        "Agricultural education"
        "Art education"
        "Bilingual education"
        "Chemistry education"
        "Counselor education"
        "Language education"
        "Legal education"
        "Mathematics education"
        "Medical education"
        "Military education and training",
        "Music education",
        "Nursing education",
        "Peace education",
        "Physical education/Sports coaching",
        "Physics education",
        "Reading education",
        "Religious education",
        "Science education",
        "Special education",
        "Sex education",
        "Sociology of education",
        "Technology education",
        "Vocational education"
      ]

      LAW = [
        "Canon law",
        "Comparative law",
        "Constitutional law",
        "Competition law",
        "Criminal law",
        "Islamic law",
        "Jewish law",
        "Jurisprudence",
        "Civil law",
        "Human Rights Law"
        "Others"
      ]

      SCIENCE_AND_MATHEMATICS = [
        "Biology",
        "Chemistry",
        "Earth sciences",
        "Physics",
        "Space sciences",
        "Mathematics",
        "Computer sciences",
        "Logic",
        "Statistics",
        "Systems science"
      ]

      ENGINEERING = [
      "Applied engineering"
      "Architectural engineering"
      "Audio engineering"
      "Biological engineering"
      "Broadcast engineering"
      "Building engineering"
      "Building services engineering"
      "Ceramics engineering"
      "Chemical engineering"
      "Computer engineering"
      "Computer Science and Engineering"
      "Civil engineering"
      "Electrical engineering"
      "Electronics engineering"
      "Engineering Science"
      "Environmental engineering"
      "Fire protection engineering"
      "Food engineering"
      "Glass engineering"
      "Industrial engineering (includes manufacturing and production engineering)"
      "Marine engineering"
      "Materials engineering"
      "Mechanical engineering"
      "Mechatronic engineering"
      "Military engineering"
      "Nuclear engineering"
      "Instrumentation engineering"
      "Offshore engineering"
      "Optical engineering"
      "Petroleum engineering"
      "Planetary engineering / Geoengineering"
      "Safety engineering"
      "Software engineering"
      "Sports engineering"
      "Systems engineering"
      "Textile engineering"
      ]

      MEDICAL_PHRMECY_AND_HEALTHCARE = [
        "Homeopathic",
        "Ayurvedic",
        "Allopathy"

        #medicine/pharmecy
        "Clinical laboratory sciences/Clinical pathology/Laboratory medicine",
        "Clinical Physiology",
        "Dentistry",
        "Health informatics/Clinical informatics",
        "Nursing",
        "Midwifery-Obstetrics",
        "Nutrition and dietetics",
        "Optometry",
        "Orthoptics",
        "Physiotherapy",
        "Occupational therapy",
        "Speech and language pathology",
        "Internal medicine",
        "Pharmacy",
        "Pharmaceutical sciences",
        "Physical fitness",
        "Podiatry",
        "Primary care",
        "Psychiatry",
        "Psychology",
        "Public health",
        "Radiology",
        "Recreation therapy",
        "Rehabilitation medicine",
        "Respiratory medicine",
        "Respiratory therapy",
        "Rheumatology",
        "Sports medicine",
        "Surgery",
        "Urology",
        "Veterinary medicine"
      ]

      COMPUTER_APPLICATION = [
      ]


  end

end
