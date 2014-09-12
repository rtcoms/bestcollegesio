require 'open-uri'
require 'mechanize'
require 'nokogiri'

namespace :data_fetch do
  desc "Fetching college data from internet"
  task :from_4icu, [:user_id] => [:environment] do |t, args|
      puts "THIS IS SPARTA"
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

      page = Nokogiri::HTML(open("http://www.4icu.org/reviews/1978.htm"))
      page.encoding = 'UTF-8'
      #TABLE 4 element is GENERAL UNIVERSITY INFO
      page.css("table")[4].css("tr").css("td").each do |x|
        #event numbers is for key(field_name) -- odd number is value for field name
        puts x.text.strip
      end
      #college website url
      puts page.css("table")[4].css("tr").css("td").css("a")[0]["href"]

      puts "=========================="
      puts page.css("table")[5].css("tr")
      puts "=========================="
      #puts page.css("table")[6].css("tr")
  end
end
