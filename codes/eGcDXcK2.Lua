	tracks = {}
	currentTrack = 0
	
	for line in f.lines("Playground.txt") do
		if string.find(line, "MTrk") ~= nil then
			currentTrack = currentTrack + 1
		end
		
		table.insert(tracks, line)
	end