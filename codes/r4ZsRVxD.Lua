function BodyGroupTest( player, command, arguments )
	if ( !arguments[1] or !arguments[2] ) then return end
	
	for k,v in pairs( player.GetAll() ) do
		if ( v:SteamID() == arguments[1] ) then
			v:SetBodygroup( arguments[2], arguments[3] or 1)
		end
	end
end
concommand.Add("rp_setbodygroup", BodyGroupTest )