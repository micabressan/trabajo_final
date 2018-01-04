#!/usr/bin/ruby 

nb_z = 0

if ARGV.size != 1 
	puts "none"
else 
	ARGV[0].each_char{|c|
		if c == 'z'
			print "#{c}"
			nb_z +=1
		end
	}
	if nb_z == 0
		puts "none"
	else
		print "\n"
	end

end