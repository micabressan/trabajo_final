require 'rubygems'
require 'nokogiri'
require 'rest-client'

def execution_loop(period)
  loop do
    before = Time.now
    yield
    interval = period - (Time.now - before)
    sleep(interval) if interval > 0
  end
end

execution_loop(60) do

  page = Nokogiri::HTML(RestClient.get("https://vk.com/psychohell"))
  offline = page.css('.profile_time_lv').text
  online = page.css('.profile_online_lv').text

  if offline.include?("заходил") || offline.include?("сети")
    puts "Вадим #{offline}"

  else
    puts "Вадим сейчас #{online}"
  end
end