package me.chaoskiller99.SkyPvP.Listeners;

import me.chaoskiller99.SkyPvP.Main.GameState;
import me.chaoskiller99.SkyPvP.Main.Global;
import me.chaoskiller99.SkyPvP.Main.Main;

import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.entity.EntityDamageByEntityEvent;

public class Damag_Listener implements Listener{
	
	@EventHandler
	public void onDamgae(EntityDamageByEntityEvent e){
	
		if(Main.status == GameState.InGame){
			
			if(e.getEntity() instanceof Player && e.getDamager() instanceof Player){
				
				Player en = (Player)e.getEntity();
				Player d = (Player)e.getDamager();
				
				if(Global.alive.contains(en.getName()) && Global.alive.contains(d.getName())){
					
					e.setCancelled(false);
					if(Global.lastDamage.containsKey(en)){
						Global.lastDamage.remove(en);
					}
					Global.lastDamage.put(en, d);
					
				}else{
					e.setCancelled(true);
				}
				
			}
			
			
		}else{
			e.setCancelled(true);
		}
		
	}
}