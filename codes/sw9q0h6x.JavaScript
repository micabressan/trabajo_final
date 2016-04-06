package me.PvPNiK.DayZ_Loots_Blood.main;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Random;
import java.util.Set;

import net.minecraft.server.v1_8_R3.TileEntityChest;

import org.bukkit.Bukkit;
import org.bukkit.ChatColor;
import org.bukkit.Location;
import org.bukkit.Material;
import org.bukkit.World;
import org.bukkit.block.Block;
import org.bukkit.block.Chest;
import org.bukkit.command.Command;
import org.bukkit.command.CommandExecutor;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.inventory.InventoryCloseEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;
import org.bukkit.plugin.java.JavaPlugin;
import org.bukkit.scheduler.BukkitRunnable;
import org.bukkit.scheduler.BukkitScheduler;

public class main extends JavaPlugin implements Listener,CommandExecutor {
	
	String chestname = getConfig().getString("chestname");
	String worldname = getConfig().getString("worldname");
	
	@Override
	public void onEnable() {
		getLogger().info("GunZ_Loots_Blood Enabled!");
		getConfig().options().copyDefaults(true);
		saveConfig();
		Bukkit.getServer().getPluginManager().registerEvents(this, this);
	
		BukkitScheduler scheduler = Bukkit.getServer().getScheduler();
        scheduler.scheduleSyncRepeatingTask(this, new Runnable() {
            @Override
            public void run() {
            	itemChest();
				armorChest();
				gunsChest();
				Bukkit.broadcastMessage(ChatColor.GOLD + "The chests loot have been reset!");
            }
        }, 0L, 20*60*10L);
		
	}
	
	@Override
	public void onDisable() {
		getLogger().info("GunZ_Loots_Blood Disabled!");
	}
	
	public void createChest(Player p){
		Block b = p.getTargetBlock((Set<Material>) null, 100);
		if (b.getType() == Material.ENDER_CHEST){
			getConfig().set("chestnum", getConfig().getInt("chestnum") + 1);
			Location loc = b.getLocation();
			getConfig().set("chests." + getConfig().getInt("chestnum"), loc);
			saveConfig();
			b.setType(Material.CHEST);
			p.sendMessage(ChatColor.GREEN + " created new chest number(" + getConfig().getInt("chestnum") + ") :" + loc);
		}else {
			p.sendMessage(ChatColor.RED + " invalid block, please look at ENDER CHEST");
		}
	}
	
	public void armorChest(){
		double o = 2.5;
		for (int y = 1 ; y <= getConfig().getInt("chestnum") ; y++){
			Location loc = (Location) getConfig().get("chests." + y);
			Bukkit.getWorld(worldname).getBlockAt(loc).setType(Material.CHEST);
			
			Chest che = (Chest) loc.getBlock().getState();
			for (int i = 0 ; i <= 2 ; i++){
				double ch = new Random().nextInt(75)+1;
				if (ch >= 5/4 && ch <= 10/4){
					int r = new Random().nextInt(4)+1;
					if (che.getInventory().contains(Material.DIAMOND_BOOTS) || che.getInventory().contains(Material.DIAMOND_LEGGINGS)
					|| che.getInventory().contains(Material.DIAMOND_CHESTPLATE) || che.getInventory().contains(Material.DIAMOND_HELMET)){
						break;
					}else {
						if (r == 1){
							che.getInventory().addItem(new ItemStack(Material.DIAMOND_BOOTS , 1));
							break;
						}else if (r == 2){
							che.getInventory().addItem(new ItemStack(Material.DIAMOND_LEGGINGS , 1));
							break;
						}else if (r == 3){
							che.getInventory().addItem(new ItemStack(Material.DIAMOND_CHESTPLATE , 1));
							break;
						}else if (r == 4){
							che.getInventory().addItem(new ItemStack(Material.DIAMOND_HELMET , 1));
							break;
						}
					}
				}else if (ch > 10/o && ch <= 15/o){
					int r = new Random().nextInt(4)+1;
					if (che.getInventory().contains(Material.IRON_BOOTS) || che.getInventory().contains(Material.IRON_LEGGINGS)
							|| che.getInventory().contains(Material.IRON_CHESTPLATE) || che.getInventory().contains(Material.IRON_HELMET)){
						break;
					}else {
						if (r == 1){
							che.getInventory().addItem(new ItemStack(Material.IRON_BOOTS , 1));
							break;
						}else if (r == 2){
							che.getInventory().addItem(new ItemStack(Material.IRON_LEGGINGS , 1));
							break;
						}else if (r == 3){
							che.getInventory().addItem(new ItemStack(Material.IRON_CHESTPLATE , 1));
							break;
						}else if (r == 4){
							che.getInventory().addItem(new ItemStack(Material.IRON_HELMET , 1));
							break;
						}
					}
				}else if (ch > 15/o && ch <= 20/o){
					int r = new Random().nextInt(4)+1;
					if (r == 1){
						che.getInventory().addItem(new ItemStack(Material.CHAINMAIL_BOOTS , 1));
						break;
					}else if (r == 2){
						che.getInventory().addItem(new ItemStack(Material.CHAINMAIL_LEGGINGS , 1));
						break;
					}else if (r == 3){
						che.getInventory().addItem(new ItemStack(Material.CHAINMAIL_CHESTPLATE , 1));
						break;
					}else if (r == 4){
						che.getInventory().addItem(new ItemStack(Material.CHAINMAIL_HELMET , 1));
						break;
					}
				}else if (ch > 20/o && ch <= 30/o){
					int r = new Random().nextInt(4)+1;
					if (r == 1){
						che.getInventory().addItem(new ItemStack(Material.GOLD_BOOTS , 1));
						break;
					}else if (r == 2){
						che.getInventory().addItem(new ItemStack(Material.GOLD_LEGGINGS , 1));
						break;
					}else if (r == 3){
						che.getInventory().addItem(new ItemStack(Material.GOLD_CHESTPLATE , 1));
						break;
					}else if (r == 4){
						che.getInventory().addItem(new ItemStack(Material.GOLD_HELMET , 1));
						break;
					}
				}else if (ch > 30/o && ch <= 50/o){
					int r = new Random().nextInt(4)+1;
					if (r == 1){
						che.getInventory().addItem(new ItemStack(Material.LEATHER_BOOTS , 1));
						break;
					}else if (r == 2){
						che.getInventory().addItem(new ItemStack(Material.LEATHER_LEGGINGS , 1));
						break;
					}else if (r == 3){
						che.getInventory().addItem(new ItemStack(Material.LEATHER_CHESTPLATE , 1));
						break;
					}else if (r == 4){
						che.getInventory().addItem(new ItemStack(Material.LEATHER_HELMET , 1));
						break;
					}
				}
			}
		}
	}
	
	public void itemChest(){
		double o = 1.5;
		
		ItemStack bandage = new ItemStack(Material.PAPER, 1);
		ItemMeta bitm = bandage.getItemMeta();
		bitm.setDisplayName(ChatColor.YELLOW + "Bandage");
		ArrayList<String> lore = new ArrayList<String>();
		lore.add("Right click to stop bleeding");
		bitm.setLore(lore);
		bandage.setItemMeta(bitm);
		for (int y = 1 ; y <= getConfig().getInt("chestnum") ; y++){
			Location loc = (Location) getConfig().get("chests." + y);
			Bukkit.getWorld(worldname).getBlockAt(loc).setType(Material.CHEST);
			
			Chest che = (Chest) loc.getBlock().getState();
			try{
			    Field inventoryField = che.getClass().getDeclaredField("chest");
			    inventoryField.setAccessible(true);
			    TileEntityChest teChest = ((TileEntityChest) inventoryField.get(che));
			    teChest.a(ChatColor.RED + chestname);
			}
			catch (Exception e){
			     e.printStackTrace();
			}
			for (int i = 0 ; i <= 26 ; i++){
				double ch = new Random().nextInt(115)+1;
				if (ch >= 5/5 && ch <= 10/5){
					int r = new Random().nextInt(2)+1;
					if (r == 1){
					if (che.getInventory().contains(Material.DIAMOND_SWORD) || che.getInventory().contains(Material.GOLD_SWORD) || che.getInventory().contains(Material.WOOD_SWORD) || che.getInventory().contains(Material.IRON_SWORD) || che.getInventory().contains(Material.STONE_SWORD)){
						break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.DIAMOND_SWORD ,1));
							che.getInventory().addItem(bandage);
							continue;
						}
					}else if (r == 2){
						che.getInventory().setItem(i, new ItemStack(Material.MUSHROOM_SOUP ,1));
						continue;
					}
				}else if (ch > 10/o && ch <= 15/o){
					int r = new Random().nextInt(2)+1;
					if (r == 1){
						if (che.getInventory().contains(Material.DIAMOND_SWORD) || che.getInventory().contains(Material.GOLD_SWORD) || che.getInventory().contains(Material.WOOD_SWORD) || che.getInventory().contains(Material.IRON_SWORD) || che.getInventory().contains(Material.STONE_SWORD)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.GOLD_SWORD ,1));
							continue;
						}
					}else if (r == 2){
						if (che.getInventory().contains(Material.GOLDEN_APPLE)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.GOLDEN_APPLE ,1));
							che.getInventory().addItem(bandage);
							continue;
						}
					}
				}else if (ch > 15/2 && ch <= 20/2){
					int r = new Random().nextInt(4)+1;
					if (r == 1){
						if (che.getInventory().contains(Material.DIAMOND_SWORD) || che.getInventory().contains(Material.GOLD_SWORD) || che.getInventory().contains(Material.WOOD_SWORD) || che.getInventory().contains(Material.IRON_SWORD) || che.getInventory().contains(Material.STONE_SWORD)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.IRON_SWORD ,1));
							continue;
						}
					}else if (r == 2){
						if (che.getInventory().contains(Material.STONE_PICKAXE) || che.getInventory().contains(Material.IRON_PICKAXE) || che.getInventory().contains(Material.DIAMOND_PICKAXE) || che.getInventory().contains(Material.WOOD_PICKAXE)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.IRON_PICKAXE ,1));
							continue;
						}
					}else if (r == 3){
						if (che.getInventory().contains(Material.RAW_FISH)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.RAW_FISH ,1));
							continue;
						}
					}else if (r == 4){
						if (che.getInventory().contains(Material.ROTTEN_FLESH)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.ROTTEN_FLESH ,1));
							continue;
						}
					}
				}else if (ch > 20/o && ch <= 25/o){
					int r = new Random().nextInt(4)+1;
					if (r == 1){
						if (che.getInventory().contains(Material.DIAMOND_SWORD) || che.getInventory().contains(Material.GOLD_SWORD) || che.getInventory().contains(Material.WOOD_SWORD) || che.getInventory().contains(Material.IRON_SWORD) || che.getInventory().contains(Material.STONE_SWORD)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.STONE_SWORD ,1));
							continue;
						}
					}else if (r == 2){
						if (che.getInventory().contains(Material.RAW_BEEF)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.RAW_BEEF ,1));
							continue;
						}
					}else if (r == 3){
						if (che.getInventory().contains(Material.PORK)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.PORK ,1));
							continue;
						}
					}else if (r == 4){
						if (che.getInventory().contains(Material.COOKED_CHICKEN)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.COOKED_CHICKEN ,1));
							continue;
						}
					}
				}else if (ch > 25/o && ch <= 30/o){
					int r = new Random().nextInt(5)+1;
					if (r == 1){
						if (che.getInventory().contains(Material.DIAMOND_SWORD) || che.getInventory().contains(Material.GOLD_SWORD) || che.getInventory().contains(Material.WOOD_SWORD) || che.getInventory().contains(Material.IRON_SWORD) || che.getInventory().contains(Material.STONE_SWORD)){
							continue;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.WOOD_SWORD ,1));
							continue;
						}
					}else if (r == 2){
						if (che.getInventory().contains(Material.STONE_PICKAXE) || che.getInventory().contains(Material.IRON_PICKAXE) || che.getInventory().contains(Material.DIAMOND_PICKAXE) || che.getInventory().contains(Material.WOOD_PICKAXE)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.STONE_PICKAXE ,1));
							continue;
						}
					}else if (r == 3){
						if (che.getInventory().contains(Material.COOKED_BEEF)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.COOKED_BEEF ,1));
							continue;
						}
					}else if (r == 4){
						if (che.getInventory().contains(Material.PORK)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.PORK ,1));
							continue;
						}
					}else if (r == 5){
						if (che.getInventory().contains(Material.COOKED_CHICKEN)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.COOKED_CHICKEN ,1));
							continue;
						}
					}
				}else if (ch > 30/o && ch <= 35/o){
					int r = new Random().nextInt(4)+1;
					if (r == 1){
						che.getInventory().setItem(i, new ItemStack(Material.IRON_AXE ,1));
						continue;
					}else if (r == 2){
						if (che.getInventory().contains(Material.DIAMOND_SWORD) || che.getInventory().contains(Material.GOLD_SWORD) || che.getInventory().contains(Material.WOOD_SWORD) || che.getInventory().contains(Material.IRON_SWORD) || che.getInventory().contains(Material.STONE_SWORD)){
							che.getInventory().setItem(i, new ItemStack(Material.INK_SACK , 2, (short) 2));
							che.getInventory().setItem(i, new ItemStack(Material.SNOW_BALL , 2));
							continue;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.GOLD_SWORD ,1));
							continue;
						}
					}else if (r == 3){
						che.getInventory().setItem(i, new ItemStack(Material.INK_SACK , 30,(short) 6));
						che.getInventory().setItem(i, new ItemStack(Material.SNOW_BALL , 30));
						continue;
					}else if (r == 4){
						che.getInventory().setItem(i, new ItemStack(Material.APPLE ,1));
						continue;
					}
				}else if (ch > 35/o && ch <= 40/o){
					int r = new Random().nextInt(2)+1;
					if (r == 1){
						che.getInventory().setItem(i, new ItemStack(Material.INK_SACK , 30, (short) 1));
						che.getInventory().setItem(i, new ItemStack(Material.SNOW_BALL , 30));
						continue;
					}else if (r == 2){
						if (che.getInventory().contains(new ItemStack(Material.POTION , 1, (short) 8257))){
							continue;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.POTION , 1, (short) 8257));
							continue;
						}
					}
				}else if (ch > 40/o && ch <= 45/o){
					int r = new Random().nextInt(4)+1;
					if (r == 1){
						che.getInventory().setItem(i, new ItemStack(Material.IRON_SPADE ,1));
						continue;
					}else if (r == 2){
						if (che.getInventory().contains(Material.DIAMOND_SWORD) || che.getInventory().contains(Material.GOLD_SWORD) || che.getInventory().contains(Material.WOOD_SWORD) || che.getInventory().contains(Material.IRON_SWORD) || che.getInventory().contains(Material.STONE_SWORD)){
							che.getInventory().setItem(i, new ItemStack(Material.INK_SACK , 2, (short) 2));
							che.getInventory().setItem(i, new ItemStack(Material.SNOW_BALL , 2));
							continue;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.WOOD_SWORD ,1));
							continue;
						}
					}else if (r == 3){
						if (che.getInventory().contains(Material.RAW_FISH)){
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.RAW_FISH ,1));
							continue;
						}
					}else if (r == 4){
						if (che.getInventory().contains(Material.COOKED_BEEF)){
							che.getInventory().setItem(i, new ItemStack(Material.INK_SACK , 30, (short) 2));
							che.getInventory().setItem(i, new ItemStack(Material.SNOW_BALL , 30));
							break;
						}else {
							che.getInventory().setItem(i, new ItemStack(Material.COOKED_BEEF ,1));
							che.getInventory().addItem(bandage);
							continue;
						}
					}
				}else {
					che.getInventory().setItem(i, new ItemStack(Material.AIR ,1));
					continue;
				}
					
				
			}
		}
	}
	
	public void gunsChest(){
		int o = 2;
		for (int y = 1 ; y <= getConfig().getInt("chestnum") ; y++){
			Location loc = (Location) getConfig().get("chests." + y);
			Bukkit.getWorld(worldname).getBlockAt(loc).setType(Material.CHEST);
			
			Chest che = (Chest) loc.getBlock().getState();
			for (int i = 0 ; i <= 2 ; i++){
				double ch = new Random().nextInt(100)+1;
				if (ch >= 5/o && ch <= 10/o){
					che.getInventory().addItem(new ItemStack(Material.RECORD_10));
					break;
				}else if (ch > 10/o && ch <= 15/o){
					int r = new Random().nextInt(3)+1;
					if (r == 1){
						che.getInventory().addItem(new ItemStack(Material.RECORD_12));
						break;
					}else if (r == 2){
						che.getInventory().addItem(new ItemStack(Material.GOLD_RECORD));
						break;
					}else if (r == 3){
						che.getInventory().addItem(new ItemStack(Material.RECORD_4));
						break;
					}
				}else if (ch > 15/o && ch <= 20/o){
					int r = new Random().nextInt(2)+1;
					if (r == 1){
						che.getInventory().addItem(new ItemStack(Material.RECORD_7));
						break;
					}else if (r == 2){
						che.getInventory().addItem(new ItemStack(Material.RECORD_5));
						break;
					}
				}else if (ch > 20/o && ch <= 50/o){
					che.getInventory().addItem(new ItemStack(Material.RECORD_11));
					break;
				}else {
					break;
				}
			}
		}
	}
	
	
	@Override
	public boolean onCommand(CommandSender sender, Command cmd,String label, String[] args) {
		if (!(sender instanceof Player)){
			return true;
		}
		Player p = (Player) sender;
		if (p.isOp()){
			if (cmd.getName().equalsIgnoreCase("createch")){
				createChest(p);
			}
			if (cmd.getName().equalsIgnoreCase("setitem")){
				itemChest();
				armorChest();
				gunsChest();
			}
		}
		return true;
	}
	
	@EventHandler
	public void onClose(InventoryCloseEvent e){
		if (e.getInventory().getTitle().equals(ChatColor.RED + chestname)){
			Block b = e.getPlayer().getTargetBlock((Set<Material>) null, 100);
			if (b.getType() == Material.CHEST){
				Chest che = (Chest) b.getLocation().getBlock().getState();
				new BukkitRunnable() {
					@Override
					public void run() {
						try {che.getInventory().clear();b.setType(Material.AIR);} catch (Exception e2) {}
					}
				}.runTaskLater(this, 20*10L);
			}else {
				
			}
		}
	}
}