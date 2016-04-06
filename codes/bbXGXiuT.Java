	private static int getAmo(Player p, ItemStack i){
		if(i.getItemMeta().getDisplayName().contains("<") && i.getItemMeta().getDisplayName().contains(">")){
			String[] first = i.getItemMeta().getDisplayName().split(">");
			int amo = Integer.parseInt(first[1].split("<")[0].replace(" ", ""));
			return amo;
		}
		return 0;
	}
	
	public static void prepare(Player p, ItemStack i){
		if(!(getAmo(p, i) <= 0)){
			shoot(p, i);
		}
		else{
			p.sendMessage("§7[§6!§7] Vous ne pouvez plus tirer.");
		}
	}
	
	@SuppressWarnings("deprecation")
	private static void shoot(Player p, ItemStack i){
		
		p.throwSnowball();
		
		i.getItemMeta().setDisplayName(i.getItemMeta().getDisplayName().replace(String.valueOf(getAmo(p, i)), 	String.valueOf(getAmo(p, i)-1)));
	}