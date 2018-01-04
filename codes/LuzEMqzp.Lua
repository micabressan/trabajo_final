function GM:PlayerLoadout(ply) -- Make leveling up stuff such as bonus health and items for loadout on spawn with the leveling system on level_has and much much more
	if RPArrestedPlayers[ply:SteamID()] then return end
	
	ply:GetTable().RPLicenseSpawn = true
	timer.Simple(1, removelicense, ply)
	
	local Team = ply:Team() or 1
	
	ply:Give("keys")
	ply:Give("weapon_physcannon")
	ply:Give("gmod_camera")
	
	if GetConVarNumber("toolgun") == 1 or (FAdmin and FAdmin.Access.PlayerHasPrivilege(ply, "rp_tool")) or ply:IsAdmin()  then
		ply:Give("gmod_tool")
	end
	
	if GetConVarNumber("pocket") == 1 then
		ply:Give("pocket")
	end
	
	if GetConVarNumber("physgun") == 1 or (FAdmin and FAdmin.Access.PlayerHasPrivilege(ply, "rp_phys")) or ply:IsAdmin() then
		ply:Give("weapon_physgun")
	end
	
	if ply:HasPriv("rp_commands") and GetConVarNumber("AdminsCopWeapons") == 1 then
		ply:Give("door_ram")
		ply:Give("arrest_stick")
		ply:Give("unarrest_stick")
		ply:Give("stunstick")
		ply:Give("weaponchecker")
	end

	if not RPExtraTeams[Team] then return end
	for k,v in pairs(RPExtraTeams[Team].Weapons) do
		ply:Give(v)
	end
	
-- This Part! This Part! This Part! This Part! This Part! This Part! This Part!

	if ply:Level_Has(60) then
	ply:SetHealth( health + 500 )
	elseif ply:Level_Has(55) then
	ply:SetHealth( health + 450 )
	elseif ply:Level_Has(50) then
	ply:SetHealth( health + 400 )
	elseif ply:Level_Has(45) then
	ply:SetHealth( health + 350 )
	elseif ply:Level_Has(40) then
	ply:SetHealth( health + 300 )
	elseif ply:Level_Has(35) then
	ply:SetHealth( health + 250 )
	elseif ply:Level_Has(30) then
	ply:SetHealth( health + 230 )
	elseif ply:Level_Has(25) then
	ply:SetHealth( health + 200 )
	elseif ply:Level_Has(20) then
	ply:SetHealth( health + 175 )
	elseif ply:Level_Has(15) then
	ply:SetHealth( health + 150 )
	elseif ply:Level_Has(10) then
	ply:SetHealth( health + 100 )
	elseif ply:Level_Has(5) then
	ply:SetHealth( health + 50 )
	else return
	end

-- To This Part To This Part To This Part To This Part To This Part To This Part
	
	-- Switch to prefered weapon if they have it
	local cl_defaultweapon = ply:GetInfo( "cl_defaultweapon" )
	
	if ply:HasWeapon( cl_defaultweapon ) then
		ply:SelectWeapon( cl_defaultweapon )
	end
end