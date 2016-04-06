	@EventHandler
	public void breakEvent(BlockBreakEvent e){
		Player p = e.getPlayer();
		if(e.getBlock().getType().equals(Material.IRON_ORE)){
			e.getBlock().getDrops(new ItemStack(Material.IRON_ORE)).clear();
			p.getWorld().dropItem((Location) e.getBlock(), new ItemStack(Material.IRON_INGOT));
			
		}
	}

/*Voila*

Bukkit.getScheduler().scheduleAsyncDelayedTask(Bukkit.getPluginManager().getPlugin("IronFight"), new Runnable() {
                            public void run() {
                            	VariablesUtils.cooldownI.remove(p);
                                p.sendMessage(ChatColor.BLUE + "[IronFight] " + ChatColor.RED + "Tu peux à nouveau utiliser ton" + ChatColor.AQUA + " Saut");
                            }
                    }, 400);