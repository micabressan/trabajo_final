RPExtraTeams = {}
function AddExtraTeam( Name, color, model, Description, Weapons, command, maximum_amount_of_this_class, Salary, admin, Vote, Haslicense, NeedToChangeFrom)
	if not Name or not color or not model or not Description or not Weapons or not command or not maximum_amount_of_this_class or not Salary or not admin or Vote == nil then
		local text = "One of the custom teams is wrongly made! Attempting to give name of the wrongly made team!(if it's nil then I failed):\n" .. tostring(Name)
		print(text)
		hook.Add("PlayerSpawn", "TeamError", function(ply)
			if ply:IsAdmin() then ply:ChatPrint("WARNING: "..text) end
		end)	
	end
	local CustomTeam = {name = Name, model = model, Des = Description, Weapons = Weapons, command = command, max = maximum_amount_of_this_class, salary = Salary, admin = admin or 0, Vote = tobool(Vote), NeedToChangeFrom = NeedToChangeFrom, Haslicense = Haslicense}
	table.insert(RPExtraTeams, CustomTeam)
	team.SetUp(#RPExtraTeams, Name, color)
	local Team = #RPExtraTeams
	
	timer.Simple(0, function(CustomTeam, maximum_amount_of_this_class) AddTeamCommands(CustomTeam, maximum_amount_of_this_class) end, CustomTeam, maximum_amount_of_this_class)
	
	// Precache model here. Not right before the job change is done
	if type(model) == "table" then
		for k,v in pairs(model) do util.PrecacheModel(v) end
	else 
		util.PrecacheModel(model)
	end
	return Team
end