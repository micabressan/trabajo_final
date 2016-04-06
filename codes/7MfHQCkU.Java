	@EventHandler
	public void onClicInventaire(InventoryClickEvent e){
		if(GameState.isState(GameState.IN_LOBBY)){
			e.setCancelled(true);
		}else if (GameState.isState(GameState.IN_PREPVP) || GameState.isState(GameState.IN_GAME) || GameState.isState(GameState.IN_FINISH)){
			e.setCancelled(false);
		}
	}