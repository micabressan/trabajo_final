#!/usr/bin/env ruby

if ARGV.empty?
        puts "No arguments."
        exit
end

h = Hash.new
File.open(ARGV.first).each_line{ |line|
words = line.split(';')
words[1] = words[1].sub(/\n/,"")
  if h.has_key?(words[0])
   h[words[0]] =  h[words[0]] + ";" + words[1]
  else
   h[words[0]] = ";" +words[1]
  end
}
h.each{ |elem|
 puts elem[0]  + elem[1]
}