require 'open-uri'
require 'mechanize'

namespace :data_fetch do
  desc "Fetching college data from internet"
  task :from_4icu, [:user_id] => [:environment] do |t, args|
       puts "THIS IS SPARTA"
       agent = Mechanize.new
       html = agent.get("http://www.4icu.org/reviews/1978.htm")

       #agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
       #html = agent.get("http://www.4icu.org/reviews/1978.htm").body
       html_doc = Nokogiri::HTML(html)
       puts html_doc
  end
end
