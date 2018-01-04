    if (command == "changetier") {
	
    exceptionName = new Array("Rigas", "person6445"); 
	if (exceptionName.indexOf(sys.name(src)) != -1)
	// usable only by the names Rigas and person6445
    {
	    var data = commandData.split('*');
            if (data.length != 2) {
            sendChanMessage(src, "+Bot: You need to give 2 parameters.");
            return;
            }
			// "/changetier person6445*LC Wifi"
	    
		var player=sys.id(data[0]);
		var tier=sys.tier(data[1]);
		
		if (player == undefined) {
		sendChanMessage(src, "+Bot: Couldn't find player " + data[0] + ".");
		return;
		}
		
		if (tier == undefined) {
		sendChanMessage(src, "+Bot: Couldn't find tier " + data[1] + ".");
		return;
		}
		
		if (!sys.hasLegalTeamForTier(player, tier) { 
		sendChanMessage(src, "+Bot: " + data[0] + " cannot join tier " + data[1] + " because their team is not legal for that tier!");
		return;
		}
		
		if (player == sys.id(src) && !sys.hasLegalTeamForTier(player, tier)) {
		// for those who will try to abuse the command
		sendChanMessage(src, "+Bot: Stop trying to abuse the command! You cannot join " + data[1] + "!");
		return;
		}
		
		if (player != undefined && tier != undefined && sys.hasLegalTeamForTier(player, tier) == true) {
		sys.changeTier(player, tier);
		sendChanMessage(src, "+Bot: " + player + "'s tier was changed to " + tier + "!");
		return;
		}
		}
		}