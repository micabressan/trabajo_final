function kickPlayerNoMSG(player, admin, reason)
	if (not isElement(player) or type(reason) ~= "string") then return false end
	kickPlayer_(player, admin, reason)
	return true
end