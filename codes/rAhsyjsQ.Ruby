#!/usr/bin/ruby
require "pry"
require "optparse"

number_of_images=Dir["*.png"].select{|z| z=~/[0-9]{3}\.png/}.size  
seconds_pf=0.0
seconds_pl=0.0
seconds=0.0
skip_beginning=0.0
skip_end=0.0
OptionParser.new do |opts|
  opts.on("-n", "--number N",/[0-9]+/ ,"number of images, defaults to auto: [0-9]{3}.png") {|arg| number_of_images = arg.to_i}
  opts.on("-f", "--plus-at-first F",/.+/ ,"plus seconds at the first") {|arg| seconds_pf = arg.to_f}
  opts.on("-l", "--plus-at-last E",/.+/ ,"plus seconds at the last") {|arg| seconds_pl = arg.to_f}
  opts.on("-s", "--seconds S",/.+/ ,"total length of slideshow in seconds") {|arg| seconds = arg.to_f}
  opts.on("-b", "--skip-at-beginning B",/.+/ ," seconds") {|arg| skip_beginning = arg.to_f}
  opts.on("-e", "--skip-at-end E",/.+/ ," seconds") {|arg| skip_end = arg.to_f}
  opts.on_tail("-h", "--help", "Show this message") do
      STDERR.puts opts
      exit
  end  
  begin

    opts.parse!
  rescue OptionParser::ParseError => error
 
    $stderr.puts error
    $stderr.puts "(-h or --help will show valid options)"
    exit 1
  end
end


seconds_plf=seconds_pl+seconds_pf

#plus seconds for last and first

o2=[(seconds-seconds_plf-skip_beginning-skip_end)/(number_of_images)+seconds_pf+skip_beginning,*(1..number_of_images-2).map{|z| (z+1)*(seconds-seconds_plf-skip_beginning-skip_end).fdiv(number_of_images)+seconds_pf+skip_beginning},seconds-skip_end]
o1=[skip_beginning,*o2[0..-2]]
e=o1.zip o2
puts e.collect.with_index.map{|z,i| 
   begin
     [z[0],z[1]].join("\t")+"\t#{"%03d" % i}.png\t##{Time.at(z[0]).utc.strftime("%M:%S:%3N")} #{z[1]-z[0]}"
   rescue => ex
    binding.pry
   end
}.join("\n")