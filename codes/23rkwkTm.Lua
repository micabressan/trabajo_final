if CLIENT then
	local function Chat(um)
		local ply = um:ReadString()
		local mode = um:ReadString()
		local id = um:ReadString()

		if mode == "1" then
			chat.AddText(Color(255, 255, 0),"*SERVER* ",Color(255, 255, 0),ply,Color(255, 255, 0)," betritt die Galaxis.")
		elseif mode == "2" then
			chat.AddText(Color(255, 255, 0),"*",Color(255, 255, 0),ply,Color(255, 255, 0)," an alle* ",Color(255, 255, 0),ply,Color(255, 255, 0)," meldet sich zum Dienst.")
			print("("..id..")")
		elseif mode == "3" then
			chat.AddText(Color(255, 255, 0),"*",Color(255, 255, 0),ply,Color(255, 255, 0)," an alle* ",Color(255, 255, 0),ply,Color(255, 255, 0)," meldet sich vom Dienst ab.")
			--,Color(255, 255, 255)," ab.")
			print("("..id..")")
		end
	end
	usermessage.Hook("DispatchChatJoin", Chat)
end
--[[--------
ä = \195\164
Ä = \195\132
ö = \195\182
Ö = \195\150
ü = \195\188
Ü = \195\156
ß = \195\159
----------]]

local function PlyJoined( name )
	if SERVER then
		for k,v in pairs(player.GetAll()) do
			SendUserMessage("DispatchChatJoin", v, name, "1")
		end
	end
end
hook.Add( "PlayerConnect", "PlyJoined", PlyJoined )

local function PlyLoaded( ply )
	if SERVER then
		timer.Simple(5, function() --Let the player load you noodle!
			if ply:IsValid() then
				for k,v in pairs(player.GetAll()) do
					SendUserMessage("DispatchChatJoin", v, ply:GetName(), "2", ply:SteamID())
				end
			end
		end)
	end
end
hook.Add( "PlayerInitialSpawn", "PlyLoaded", PlyLoaded )

function PlyLeft( ply )
	if SERVER then
		for k,v in pairs(player.GetAll()) do
			SendUserMessage("DispatchChatJoin", v, ply:GetName(), "3", ply:SteamID())
		end
	end
end
hook.Add( "PlayerDisconnected", "PlyLeft", PlyLeft )