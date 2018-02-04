public class Commands implements CommandExecutor {
	
	Main main;
	ItemCreate itemcreate;
	public Commands(ItemCreate instance) {
		itemcreate = instance;
	}
	public Commands(Main instance) {
		main = instance;
	}
	
	public boolean onCommand(CommandSender sender, Command cmd, String label, String[] args) {
		Player player = (Player) sender;
		if (cmd.getName().equalsIgnoreCase("ck") && (sender instanceof Player) && (args.length == 2)) {
			itemcreate.createItems(player,args[0],Integer.parseInt(args[1]));
		}
		return true;
	}
}