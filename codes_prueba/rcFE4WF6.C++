ommand /drop [<text>] [<offlineplayer>]:
	aliases: dropy, stone
	trigger:
		if arg 1 is not "open" or "statystyki" or "info" or "top" or "stone" or "lowienie" or "mob" or "stonegracz" or "stonevip" or "stonesponsor":
			send "&7<&6*&7>&c========== &a> &7[&bFun&aDrop&7] &a< &c==========&7<&6*&7>"		
			send "&9Wpisz &a/Drop Open &7- &aAby otworzyc okno dropu!"
			send "&9Wpisz &a/Drop Statystyki &7- &aAby sprawdzic swoje statystyki!"	
			send "&9Wpisz &a/Drop Info <Gracz> &7- &aAby sprawdzic statystyki danego gracza!"		
			send "&9Wpisz &a/Drop Top &7- &aAby sprawdzic ranking kopaczy!"			
		arg 1 is not set:
			send "&7<&6*&7>&c========== &a> &7[&bFun&aDrop&7] &a< &c==========&7<&6*&7>"		
			send "&9Wpisz &a/Drop Open &7- &aAby otworzyc okno znalezionych punktow!"
			send "&9Wpisz &a/Drop Statystyki &7- &aAby sprawdzic swoje statystyki!"	
			send "&9Wpisz &a/Drop Info <Gracz> &7- &aAby sprawdzic statystyki danego gracza!"		
			send "&9Wpisz &a/Drop Top &7- &aAby sprawdzic ranking kopaczy!"				
		arg 1 is "open":
			open chest with 4 rows named "&2&lDrop na &b&lFun-Craft" to player
			wait 2 tick
			format slot 0 of player with air to be unstealable
			format slot 1 of player with air to be unstealable
			format slot 2 of player with air to be unstealable
			format slot 3 of player with air to be unstealable
			format slot 4 of player with air to be unstealable
			format slot 5 of player with air to be unstealable
			format slot 6 of player with air to be unstealable
			format slot 7 of player with air to be unstealable
			format slot 8 of player with air to be unstealable
			format slot 9 of player with air to be unstealable
			format slot 10 of player with air to be unstealable
			format slot 11 of player with diamond pickaxe named "&6Drop z Stone" with lore "&eKliknij!" to close then run "drop-c %player% stone"
			format slot 12 of player with air to be unstealable
			format slot 13 of player with Fishing rod named "&6Drop z Lowienia" with lore "&eKliknij!" to close then run "drop-c %player% lowienie"
			format slot 14 of player with air to be unstealable
			format slot 15 of player with diamond Sword named "&6Drop z Mobow" with lore "&eKliknij!" to close then run "drop-c %player% mob"
			format slot 16 of player with air to be unstealable
			format slot 17 of player with air to be unstealable
			format slot 18 of player with air to be unstealable
			format slot 19 of player with air to be unstealable
			format slot 20 of player with air to be unstealable
			format slot 21 of player with air to be unstealable
			format slot 22 of player with air to be unstealable
			format slot 23 of player with air to be unstealable
			format slot 24 of player with air to be unstealable
			format slot 25 of player with air to be unstealable
			format slot 26 of player with air to be unstealable
			format slot 27 of player with book named "&6Statystyki" with lore "&eKliknij!" to close then run "drop-c %player% Statystyki"
			format slot 28 of player with air to be unstealable
			format slot 29 of player with air to be unstealable
			format slot 30 of player with air to be unstealable			
			if {drop.info.%player%} is true:
				format slot 31 of player with paper named "&6Wiadomosc dropu &7- &aWlaczone" with lore "&eKliknij!" to close then run "drop-c %player% wiaddropuoff"
			if {drop.info.%player%} is false:
				format slot 31 of player with paper named "&6WWiadomosc dropu &7- &cWylaczone" with lore "&eKliknij!" to close then run "drop-c %player% wiaddropuon"
			format slot 32 of player with air to be unstealable		
			format slot 33 of player with air to be unstealable
			format slot 34 of player with air to be unstealable		
			format slot 35 of player with gunpowder named "&4Wyjscie" with lore "&eKliknij!" to close then run ""