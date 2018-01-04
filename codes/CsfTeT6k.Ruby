require 'open3'

dest_file = "sloped_p3ds.txt"

File.open(dest_file, 'w') do |file|
	Dir.glob("P:/CA/**/*.p3d").each do |model|
		p3d = File.basename(model) 
	
		print "checking #{p3d.to_s}... "
		Open3.popen3("dep3d -LPP \"#{model.to_s}\"") do |stdin, stdout, stderr, thread|
			result = stdout.read.chomp
			if result.include? 'placement=slopelandcontact'
				file.puts(p3d)
				puts "ADDED"
			else
				puts ""
			end
		end
	end
end