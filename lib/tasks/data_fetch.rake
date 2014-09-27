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

      page = Nokogiri::HTML(open("http://www.4icu.org/reviews/1978.htm"))
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
      info_div = page.css(".section")[14].css("div")

      (0..4).to_a.each do |n|
        reference_element =  info_div.css("h4")[n]
        value_element = reference_element.next_element
        info_column_name =  info_div.css("h4")[n].text
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
      info_div = page.css(".section")[17]
      (0..6).to_a.each do |n|
        reference_element =  info_div.css("h4")[n]
        value_element = reference_element.next_element
        info_column_name =  info_div.css("h4")[n].text
        info_column_value =   if value_element.name == "h5"
                                value_element.text.strip
                              else
                                value_element.css("img").attr('src').to_s.match("1.gif").present?
                              end
        college_info[:size_info][info_column_name] = info_column_value
      end
      puts "fetched size and profile INFO"





      puts college_info
  end

end
