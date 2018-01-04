package me.daanisaanwezig.jobs;

import java.util.List;

import org.bukkit.ChatColor;
import org.bukkit.command.Command;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;
import org.bukkit.event.Listener;
import org.bukkit.plugin.java.JavaPlugin;

public class jobs extends JavaPlugin implements Listener{
	
	public void onEnable1() {
        getConfig().options().copyDefaults(true);
        saveConfig();
	}
	
public boolean onCommand(CommandSender sender, Command cmd, String commandLabel, String[] args) {
        
        if (!(sender instanceof Player)) {
                sender.sendMessage(ChatColor.DARK_AQUA.toString() + ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY.toString() + ChatColor.BOLD + " > " + ChatColor.GRAY + "This plugin is for players only!");
                return true;
        }
       
        Player p = (Player) sender;
       
        
        if (cmd.getName().equalsIgnoreCase("jobs")) {
        	if (args.length == 0) {
        		sender.sendMessage(ChatColor.DARK_AQUA.toString() + ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY.toString() + ChatColor.BOLD + " > " + ChatColor.GRAY + "Please use '/jobs join'");
            	return true;
            }
        	if (args.length == 1) {
        		if (args[0] == "join") {
                	sender.sendMessage(ChatColor.DARK_AQUA.toString() + ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY.toString() + ChatColor.BOLD + " > " + ChatColor.GRAY + "Please choose a job! valid jobs are: Woodcutter and Miner");
                	return true;
        	}
        }
        	if (args.length == 2) {
        		if ((args[0] == "join")&& args[1] == "woodcutter") {
        			sender.sendMessage(ChatColor.DARK_AQUA.toString() + ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY.toString() + ChatColor.BOLD + " > " + ChatColor.GRAY + "You are now a" + ChatColor.GOLD+" Woodcutter");
        			List<String> names = getConfig().getStringList("woodcutter");
        			if (!names.contains(p.getName()))
        			    names.add(p.getName());
        			getConfig().set("woodcutter", names);
        			saveConfig();
        			return true;
        		}
        		//registerd niet
        		if (args[1] == "miner") {
        			sender.sendMessage(ChatColor.DARK_AQUA.toString() + ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY.toString() + ChatColor.BOLD + " > " + ChatColor.GRAY + "You are now a" + ChatColor.GOLD +" Miner");
        			getConfig().createSection(p.getName() + " miner");
        			List<String> names = getConfig().getStringList("miner");
        			if (!names.contains(p.getName()))
        			    names.add(p.getName());
        			getConfig().set("miner", names);
        			saveConfig();
        			return true;
        		}
        	}
		}
		return true;
	}
}