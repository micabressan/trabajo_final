			// If in pease zone
			if(activeChar.isInZone(ZoneType.peace_zone) && activeChar.getZone(ZoneType.peace_zone).getRestartPoints() != null)
				return player.getKarma() > 1 ? activeChar.getZone(ZoneType.peace_zone).getPKSpawn() : activeChar.getZone(ZoneType.peace_zone).getSpawn();

			// If in offshore zone == pease zone options.
			if(activeChar.isInZone(ZoneType.offshore) && activeChar.getZone(ZoneType.offshore).getRestartPoints() != null)
				return player.getKarma() > 1 ? activeChar.getZone(ZoneType.offshore).getPKSpawn() : activeChar.getZone(ZoneType.offshore).getSpawn();

			// If in restart zone options.
			if(activeChar.isInZone(ZoneType.restart) && activeChar.getZone(ZoneType.restart).getRestartPoints() != null)
				return player.getKarma() > 1 ? activeChar.getZone(ZoneType.offshore).getPKSpawn() : activeChar.getZone(ZoneType.offshore).getSpawn();