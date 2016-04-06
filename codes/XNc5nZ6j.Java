	@Override
	public boolean onCommand(CommandSender sender, Command cmd, String label, String[] args) {
		
		Player p = (Player) sender;
		
		if(label.equalsIgnoreCase("stop")){
			if(p.isOp() == true){
				Bukkit.dispatchCommand(Bukkit.getConsoleSender(), "restart");
			}
		}
		return false;
	}