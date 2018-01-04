%ArmorConvert = (
	135056 => {
				"Warrior" => 135015,
				"Cleric" => 135015,
				"Paladin" => 135015,
				"Ranger" => 135008,
				"Shadowknight" => 135015,
				"Druid" => 135022,
				"Monk" => 135029,
				"Bard" => 135015,
				"Rogue" => 135008,
				"Shaman" => 135008,
				"Necromancer" => 135001,
				"Wizard" => 135001,
				"Magician" => 135001,
				"Enchanter" => 135001,
				"Beastlord" => 135022,
				"Berserker" => 135008
	},
	135052	=>	{
				"Warrior" => 135018,
				"Cleric" => 135018,
				"Paladin" => 135018,
				"Ranger" => 135011,
				"Shadowknight" => 135018,
				"Druid" => 135025,
				"Monk" => 135032,
				"Bard" => 135018,
				"Rogue" => 135011,
				"Shaman" => 135011,
				"Necromancer" => 135004,
				"Wizard" => 135004,
				"Magician" => 135004,
				"Enchanter" => 135004,
				"Beastlord" => 135025,
				"Berserker" => 135011
	},
	135050	=>	{
				"Warrior" => 135019,
				"Cleric" => 135019,
				"Paladin" => 135019,
				"Ranger" => 135012,
				"Shadowknight" => 135019,
				"Druid" => 135026,
				"Monk" => 135033,
				"Bard" => 135019,
				"Rogue" => 135012,
				"Shaman" => 135012,
				"Necromancer" => 135005,
				"Wizard" => 135005,
				"Magician" => 135005,
				"Enchanter" => 135005,
				"Beastlord" => 135026,
				"Berserker" => 135012
	},
	135055	=>	{
				"Warrior" => 135020,
				"Cleric" => 135020,
				"Paladin" => 135020,
				"Ranger" => 135013,
				"Shadowknight" => 135020,
				"Druid" => 135027,
				"Monk" => 135034,
				"Bard" => 135020,
				"Rogue" => 135013,
				"Shaman" => 135013,
				"Necromancer" => 135006,
				"Wizard" => 135006,
				"Magician" => 135006,
				"Enchanter" => 135006,
				"Beastlord" => 135027,
				"Berserker" => 135013
	},
);
	
sub EVENT_ITEM_CLICK {
	my $ItemToSummon = $ArmorConvert{$itemid}->{$class};
	$client->Message(15, "ay " . $ItemToSummon . "");	#:: Debug remove later
	#if ($itemid ~~ (keys %ArmorConvert)) {
		#if (plugin::check_hasitem($client,$ArmorConvert{$itemid}->{$class})) {
		 if (plugin::check_hasitem($client,$ArmorConvert{$itemid}->{$class}) and LoreItem($ArmorConvert{$itemid}->{$class})) {
			$client->Message(15, "ERROR: Claiming this item would result in a lore item.");
			$client->SummonItem($itemid, 1); 
		} else {
			$client->SummonItem($ArmorConvert{$itemid}->{$class},1);
		}
	#}
}

sub LoreItem {
	my $ic = $_[0];
	my $dbh = plugin::MySQL_Connect();
	my $sth = $dbh->prepare("SELECT `loregroup` FROM `items` WHERE ID = ".$ic." LIMIT 1");
	$sth->execute();	
	@data = $sth->fetchrow_array();
	$sth->finish();
	$dbh->disconnect();
	if ($data[0] == -1) { return 1; }
	else { return 0; }
}