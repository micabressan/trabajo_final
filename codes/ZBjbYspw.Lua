	

tracks = {}
	currentTrack = 0
	
	for line in f.lines("Playground.txt") do
		if string.find(line, "MTrk") ~= nil then
			currentTrack = currentTrack + 1
			if not tracks[currentTrack] then
				tracks[currentTrack] = {}
			end
		end
		
		table.insert(tracks[currentTrack], line)
	end