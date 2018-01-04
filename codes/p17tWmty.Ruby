require 'rubygems'
require 'nokogiri'
require 'rest-client'

page = Nokogiri::HTML(RestClient.get("https://vk.com/psychohell"))
offline = page.css('.profile_time_lv').text
online = page.css('.profile_online_lv').text

case

  when offline.include?("заходил") || offline.include?("сети")
    puts "Вадим #{offline}"

  else
    puts "Вадим сейчас #{online}"
end