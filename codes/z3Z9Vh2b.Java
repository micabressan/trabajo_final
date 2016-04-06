package me.blok601.tp;

import org.bukkit.ChatColor;
import org.bukkit.Location;
import org.bukkit.command.Command;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;
import org.bukkit.plugin.java.JavaPlugin;

public class Main extends JavaPlugin{
	
	public void onEnable(){
		getLogger().info("Teleport has been enabled!");
		
	}
	
	public void onDisable(){
		getLogger().info("Teleport has been disabled!");
		
	}
	
	public boolean onCommand(CommandSender sender, Command cmd, String label, String args[]){
		Player player = (Player) sender;
		if(cmd.getName().equalsIgnoreCase("tpx")){
			if(args.length == 0){  //Check if they only do /tpx
				player.sendMessage(ChatColor.RED + "Incorrect usage! Use the command like this: /tpx <player>");
			}else if(args.length == 1){    //Check if a player is specified 
				@SuppressWarnings("deprecation")
				Player player1 = player.getServer().getPlayer(args[0]);
				Location player1Loc = player1.getLocation();
				player.teleport(player1Loc);
				player.sendMessage(ChatColor.GREEN + "Teleported you to " + player1.getName());
			}
		}
		return false;
	}

}