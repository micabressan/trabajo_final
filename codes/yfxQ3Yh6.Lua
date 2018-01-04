	if ply:Level_Has(60) then
		ply:SetHealth( health + 500 )
		ply:SetArmor( 300 )
	elseif ply:Level_Has(55) then
		ply:SetHealth( health + 450 )
		ply:SetArmor( 250 )
		ply:Give( "weapon_pistol" )
	elseif ply:Level_Has(50) then
		ply:SetHealth( health + 400 )
		ply:SetArmor( 225 )
		ply:Give( "weapon_pistol" )
	elseif ply:Level_Has(45) then
		ply:SetHealth( health + 350 )
		ply:SetArmor( 200 )
		ply:Give( "weapon_pistol" )
	elseif ply:Level_Has(40) then
		ply:SetHealth( health + 300 )
		ply:SetArmor( 175 )
		ply:Give( "weapon_pistol" )
	elseif ply:Level_Has(35) then
		ply:SetHealth( health + 250 )
		ply:SetArmor( 150 )
		ply:Give( "weapon_pistol" )
	elseif ply:Level_Has(30) then
		ply:SetHealth( health + 230 )
		ply:SetArmor( 125 )
		ply:Give( "weapon_pistol" )
	elseif ply:Level_Has(25) then
		ply:SetHealth( health + 200 )
		ply:SetArmor( 100 )
		ply:Give( "weapon_pistol" )
	elseif ply:Level_Has(20) then
		ply:SetHealth( health + 175 )
		ply:SetArmor( 75 )
		ply:Give( "weapon_pistol" )
	elseif ply:Level_Has(15) then
		ply:SetHealth( health + 150 )
		ply:Give( "weapon_pistol" )
		ply:SetArmor( 50 )
	elseif ply:Level_Has(10) then
		ply:SetHealth( health + 100 )
		ply:SetArmor( 25 )
	elseif ply:Level_Has(5) then
		ply:SetHealth( health + 50 )
	end