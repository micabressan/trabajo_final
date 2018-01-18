# - Recursively extracts multi-part rar archives. This tool is useful to run at the conclusion of downloading a compressed torrent.
#
# - Example usage: ruby clean.rb "C:\Entertainment\TV Shows\"

if ARGV.length != 1
	raise "Incorrect number of arguments"
end

# Sanitize input
ARGV[0] = ARGV[0].gsub("\\","\/")

Dir[ARGV.first + "/**/*"].each do |f|
	# Get Directory
	f = f.split("\/")
	f.pop
	f = f.join("\/")

	Dir[f + "\/*.rar"].each do |g|
		print "Extracting " + g.split("\/").last + "..."
		#system "\"C:\\Program Files\\WinRar\\WinRAR.exe\" x -IBCK -o+ \"" + g.gsub("\/","\\") + "\" \"" + f.gsub("\/","\\")
		puts " finished"
		Dir[f + "\/*.r[0-9][0-9]"].each do |h|
			#File.delete(h)
		end
		#File.delete(g)
		print g
	end
en