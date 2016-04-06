-- Stairs 0.0.1 by Mickplouffe

-- Init --

do
	ver = 0.1
    x = 0
	y = 0
	z = 0
	depth = 0
end

-- Intro --

do
		term.clear()
		textutils.slowPrint("-------------------------------")
		textutils.slowPrint("The S-Stairs V" ..ver)
		textutils.slowPrint("-------------------------------")
		print("Enter to continue...")
		io.read()
end

-- Read --

while true do
	write("So, How deep?")
	deoth = io.read()
    depth = tonumber(depth)
	if depth < 0 then
		print("Sorry, this is to low.")
			else if depth > 255 then
				print("How can i dig down, more then the max hieght of the world...?")
					else if depth < 256 || depth > 0 then
						break
							else
								print("Sorry i don't understand...")
			end
		end
	end
end

-- Main -- 

while true do
	if y == depth then
		break
	else
		
		
		
		
	end
	
	
end