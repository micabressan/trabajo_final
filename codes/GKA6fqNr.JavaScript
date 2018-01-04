package me.daanisaanwezig.jobs;

import java.util.List;

import org.bukkit.ChatColor;
import org.bukkit.command.Command;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;
import org.bukkit.event.Listener;
import org.bukkit.plugin.java.JavaPlugin;

public class jobs extends JavaPlugin implements Listener{
	
	@Override
	public void onDisable() {
	         System.out.println("Jobs disabled!");
	}
	public void onEnable() {
        getConfig().options().copyDefaults(true);
        saveConfig();
	}
	@Override
public boolean onCommand(CommandSender sender, Command cmd, String label, String[] args) {
	
	Player p = (Player) sender;
        
        if (!(sender instanceof Player)) {
                p.sendMessage(ChatColor.DARK_AQUA +""+ ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY +""+ ChatColor.BOLD + " > " + ChatColor.GRAY + "This plugin is for players only!");
                return false;
        }   
        
        if (label.equalsIgnoreCase("jobs")) {
        	if (args.length == 0) {
        		p.sendMessage(ChatColor.DARK_AQUA +""+ ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY +""+ ChatColor.BOLD + " > " + ChatColor.GRAY + "Please use '/jobs join'");
            	return false;
            }
        	if (args.length == 1) {
        		if (args[0] == "join") {
                	p.sendMessage(ChatColor.DARK_AQUA +""+ ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY +""+ ChatColor.BOLD + " > " + ChatColor.GRAY + "Please choose a job! valid jobs are: Woodcutter and Miner");
                	return false;
        	}
        }
        	if (args.length == 2) {
        		if ((args[0] == "join")&& args[1] == "woodcutter") {
        			p.sendMessage(ChatColor.DARK_AQUA +""+ ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY +""+ ChatColor.BOLD + " > " + ChatColor.GRAY + "You are now a" + ChatColor.GOLD+" Woodcutter");
        			List<String> WoodcutterList = getConfig().getStringList("woodcutter");
        			WoodcutterList.add(p.getName());
        			getConfig().set("woodcutter", WoodcutterList);
        			saveConfig();
        			return false;
        		}
        		else if (args[1] == "miner") {
        			p.sendMessage(ChatColor.DARK_AQUA +""+ ChatColor.BOLD + "Jobs" + ChatColor.DARK_GRAY +""+ ChatColor.BOLD + " > " + ChatColor.GRAY + "You are now a" + ChatColor.GOLD +" Miner");
        			List<String> MinerList = getConfig().getStringList("miner");
        			MinerList.add(p.getName());
        			getConfig().set("miner", MinerList);
        			saveConfig();
        			return false;
        		}
        	}
		}
		return false;
	}
}