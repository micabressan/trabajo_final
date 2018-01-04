if(cmd[0].equals("::stake")) {
	int amount = Integer.parseInt(cmd[1]);
	if(player.getInventory().contains(995, amount)) {
		player.sm("Staking "+amount+", Good luck!");
		player.getInventory().deleteItem(995, amount);
		int random = Misc.random(1, 100);
		if(random >= 50) {
			player.sm("You've won! Congratulations!");
			player.getInventory().addItem(995, amount*2);
		} else {
			player.sm("I'm sorry, better luck next time.");
		}
	} else {
		player.sm("You do not have enough coins in your inventory to cover this!");
	}
}

if(cmd[0].equals(".stake")) {
	int amount = Integer.parseInt(cmd[1]);
	if(player.getInventory().contains(995, amount)) {
		player.sm("Staking "+amount+", Good luck!");
		player.getInventory().deleteItem(995, amount);
		int random = Misc.random(1, 100);
		if(random >= 50) {
			player.sm("You've won! Congratulations!");
			player.getInventory().addItem(995, amount*2);
		} else {
			player.sm("I'm sorry, better luck next time.");
		}
	} else {
		player.sm("You do not have enough coins in your inventory to cover this!");
	}
}