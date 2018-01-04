/*
 * Codeinator Version 1.0.0 for Zarkov.net
 * Should this be released to the Bukkit Forums? HELL YEAH. 
 * Written by RROD
 * 
 * Twitter: mc_RROD. 
 */


package org.codeinator;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.bukkit.ChatColor;
import org.bukkit.util.config.Configuration;
import org.bukkit.block.Block;
import org.bukkit.command.Command;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;
import org.bukkit.plugin.PluginDescriptionFile;
import org.bukkit.plugin.java.JavaPlugin; 

public class Codeinator extends JavaPlugin {
	public Boolean configBoolean;
	public String  configString;
	public Integer configInt;
	public Configuration config;
	
	Logger log = Logger.getLogger("Minecraft");
	
	private final HashMap<Player, ArrayList<Block>> codeinatorUsers = new HashMap<Player, ArrayList<Block>>(); 
	
	private final HashMap<Player, Boolean> debugger = new HashMap<Player,Boolean>(); 
	
	@Override
	public void onDisable() {
		//PluginDescriptionFile pdfFile = this.getDescription(); 
		//log.info("[" + pdfFile.getName() + "] version " + pdfFile.getVersion() + ". Shutting down..."); 
	}
	@Override
	public void onEnable() {	
	    config = getConfiguration(); //Sets the public config to the /plugins/Codeinator/config.yml
	    config.setHeader("## Codeinator MySQL Details. ##");
	    configString = config.getString("host", "localhost:3306/");
	    configString = config.getString("database", "database-name"); 
	    configString = config.getString("user", "root"); 
	    configString = config.getString("password", "root"); 
	    configString = config.getString("table", "web_users"); 
	    configString = config.getString("msg", "Register this code at Zarkov.net! Your code is:"); 
	    config.save();
		//PluginDescriptionFile pdfFile = this.getDescription(); 
		//log.info("[" + pdfFile.getName() + "] version " + pdfFile.getVersion() + ". Ready to accept a code! "); 
		
	}
	
	public boolean isDebugging(final Player player) {
		if (debugger.containsKey(player)) {
			return debugger.get(player); 
		} else {
			return false; 
		}
	}
	
	private SecureRandom random = new SecureRandom(); 
	
	public void setDebugging(final Player player, final boolean value) {
		debugger.put(player, value); 
	}
	
	public boolean enabled(Player player) {
		return this.codeinatorUsers.containsKey(player);		
	}
	
	public boolean onCommand(CommandSender sender, Command cmd, String commandLabel, String[] args) {
		if (cmd.getName().equalsIgnoreCase("Register") && (sender instanceof Player)) { 
		    String host   = config.getString("host");
		    String dbname = config.getString("database"); 
		    String user   = config.getString("user");
		    String pass   = config.getString("password"); 
		    String table  = config.getString("table"); 
		    String url    = "jdbc:mysql://" + host + dbname;
			String message = config.getString("msg");			
		    
			String randomNo = new BigInteger(40, random).toString(32);
			Player player = (Player)sender;
			String playerName = player.getName(); 

            try {

                Connection con = DriverManager.getConnection(url, user, pass);
                PreparedStatement st;
                
                st = con.prepareStatement("SELECT `status`, `v` FROM " + table + " WHERE `user` = ?;");
                st.setString(1, playerName);
                ResultSet rs = st.executeQuery();
                if (rs.next()){
                	if (rs.getInt("status") == 0) {
        				log.info("Player, " + playerName + " got thier code: " + rs.getString("v")); 
    	    			player.sendMessage(ChatColor.GOLD + message + " " + rs.getString("v"));
                	} else {
                		log.info("Player, " + playerName + " tried to re-register.");
                		player.sendMessage(ChatColor.RED + "You have already created your account for this username.");
                	}
                } else { 
    				log.info("Player, " + playerName + " got thier code: " + randomNo); 
	    			player.sendMessage(ChatColor.GOLD + message + " " + randomNo);

	                if (!st.isClosed())  st.close();
	                st = con.prepareStatement("INSERT INTO " + table + " (user, v) VALUES (?, ?);");
	                st.setString(1, playerName);
	                st.setString(2, randomNo);
	                st.executeUpdate();
                }
                if (!rs.isClosed())  rs.close();
                if (!st.isClosed())  st.close();
                if (!con.isClosed()) con.close();
            } catch (SQLException ex) {
            	log.info("[Codinator] Error in registration command: ");
                log.info(ex.getMessage());
                ex.printStackTrace();
            }
		}
		return true;
	}
}