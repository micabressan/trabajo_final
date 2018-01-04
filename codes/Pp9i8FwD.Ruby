#!/usr/bin/env ruby

require 'mechanize'
require 'fileutils'
require 'open-uri'
require 'net/http'

exit if ARGV[0].nil?

url    = URI.parse(ARGV[0])
mech   = Mechanize::new
page   = mech.get(url)
books  = []

FileUtils::mkdir_p folder = ARGV[1] || 'ebooks'

begin
  page.links.map.with_index { |link, i|
    Thread.new {
        (page = link.click;
         puts "[+] #{page.title}" ;
        page.links.each { |lnk|
          books << lnk.href.to_s if lnk.href.to_s =~ /http\:\/\/file\.allitebooks\.com/im
        }) if link.rel.to_s =~ /bookmark/im
    }
  }.each(&:join)
rescue Net::HTTPNotFound
  abort '[!] Finished downloading.'
end

books.each_with_index { |book, i|
  puts "(#{-~i}) Downloading #{book}"
  File.open(folder + File::SEPARATOR + File.basename(book), 'wb') { |f| f << mech.get(book).body }
}