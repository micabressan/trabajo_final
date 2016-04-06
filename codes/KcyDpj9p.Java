package com.dev.fr;

import org.bukkit.event.Listener;
import org.bukkit.plugin.java.JavaPlugin;

public class Help extends JavaPlugin implements Listener{
	
	public static Help instance;
	
	public static Help getInstance(){
		return instance;
	}
	
	@Override
	public void onEnable() {
		instance = this;
		saveDefaultConfig();
		getServer().getPluginManager().registerEvents(new GetBlocks(), this);
	}
}