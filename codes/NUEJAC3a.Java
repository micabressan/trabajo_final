	@EventHandler
	public void ChangementsStuff(PrepareItemCraftEvent e){
		if(e.getRecipe().getResult().getType() == Material.GOLDEN_APPLE){
			if(e.getRecipe().getResult().getDurability() == 1){
				e.getInventory().setResult(null);
			}
			
		}
		if(e.getRecipe().getResult().getType() == Material.WOOD_PICKAXE){
				e.getInventory().setResult(new ItemStack(Material.STONE_PICKAXE));	
		}
		if(e.getRecipe().getResult().getType() == Material.WOOD_AXE){
			e.getInventory().setResult(new ItemStack(Material.STONE_AXE));
	    }
		if(e.getRecipe().getResult().getType() == Material.WOOD_SPADE){
			e.getInventory().setResult(new ItemStack(Material.STONE_SPADE));
		
	    }
	    if(e.getRecipe().getResult().getType() == Material.WOOD_SWORD){
		    e.getInventory().setResult(new ItemStack(Material.STONE_SWORD));
        }
	    if(e.getRecipe().getResult().getType() == Material.WOOD_HOE){
		    e.getInventory().setResult(new ItemStack(Material.STONE_HOE));
        }