public class Commands implements CommandExecutor {
	
	Main main;
	ItemCreate itemcreate;
	public Commands(Main main, ItemCreate itemcreate) { 
		this.main = main; 
		this.itemcreate = itemcreate; }

	
	public boolean onCommand(CommandSender sender, Command cmd, String label, String[] args) {
		Player player = (Player) sender;
		if (cmd.getName().equalsIgnoreCase("ck") && (sender instanceof Player) && (args.length == 2)) {
			itemcreate.createItems(player,args[0],Integer.parseInt(args[1]));
		}
		return true;
	}
}



public class ItemCreate {


	public void createItems(Player player,String type,int time) {
		ItemStack item = new ItemStack(Material.NAME_TAG);
		ItemMeta im = item.getItemMeta();
		im.setDisplayName("§5 "+type+" Key");
		List<String> loreList = new ArrayList<String>();
		loreList.add("§6 Unlocks "+type+" kit for:");
		loreList.add("§6 "+time+" weeks");
		loreList.add("§8 Key "+randomString());
		im.setLore(loreList);
		item.setItemMeta(im);
		player.getInventory().addItem(item);
	}

	static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	static Random rnd = new Random();

	String randomString() {
	   StringBuilder sb = new StringBuilder(5);
	   for( int i = 0; i < 5; i++ ) 
	      sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
	   return sb.toString();
	}
}