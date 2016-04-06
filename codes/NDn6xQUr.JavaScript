package me.quinten.test;

import net.md_5.bungee.api.ChatColor;

import org.bukkit.Bukkit;
import org.bukkit.command.Command;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;
import org.bukkit.plugin.java.JavaPlugin;

public class Test extends JavaPlugin {
	
	public void onEnable() {
		Bukkit.getServer().getLogger().info("Test plugin is enabled!");
	}
	
	public void onDisable() {
		Bukkit.getServer().getLogger().info("Test plugin is disabled!");
	}
	
	public boolean onCommand(CommandSender sender, Command cmd, String commandLabel, String[] args) {
		if (cmd.getName().equalsIgnoreCase("test")) {
			if (sender instanceof Player) {
				Player p = (Player)sender;
				p.sendMessage(ChatColor.GREEN + "A Player Sent Ran This Command!");
				p.giveExp(100);
			}
			else {
				sender.sendMessage(ChatColor.RED + "This console ran this command!");
			}
		}
		return true;
		
	}

}