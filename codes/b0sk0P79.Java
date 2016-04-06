package de.scann.plugin;



import org.bukkit.Bukkit;
import org.bukkit.ChatColor;
import org.bukkit.Material;
import org.bukkit.Sound;
import org.bukkit.command.Command;
import org.bukkit.command.CommandSender;
import org.bukkit.craftbukkit.libs.org.ibex.nestedvm.util.Sort;
import org.bukkit.enchantments.Enchantment;
import org.bukkit.entity.Player;
import org.bukkit.event.Cancellable;
import org.bukkit.event.Event;
import org.bukkit.event.EventHandler;
import org.bukkit.event.EventPriority;
import org.bukkit.event.Listener;
import org.bukkit.event.block.SignChangeEvent;
import org.bukkit.event.entity.EntityDamageByEntityEvent;
import org.bukkit.event.player.PlayerChatTabCompleteEvent;
import org.bukkit.event.player.PlayerCommandPreprocessEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.plugin.Plugin;
import org.bukkit.plugin.java.JavaPlugin;

import free.InteractSignListener;
import free.SignChangeListener;

public class main
extends JavaPlugin
{
public static String name;

public void onEnable()
{
  System.out.println("plugin gestartet !");
  Bukkit.getPluginManager().registerEvents(new Playerdeathlistener(), this);
  Bukkit.getPluginManager().registerEvents(new SignChangeListener(), this);
  Bukkit.getPluginManager().registerEvents(new InteractSignListener(), this);
  
}
  public void onDisable()
  {
    System.out.println("§4plugin  gestoppt !"); 
  }

   
 

  public boolean onCommand(CommandSender sender, Command cmd, String cmdLabel, String[] args)
  {
    Player p = (Player)sender;
    if (cmd.getName().equalsIgnoreCase("heilen"))
    {
      if ((p.hasPermission("testplugin.heilen")) && 
        (args.length == 0))
      {
        p.setHealth(20);
        p.sendMessage("§aDu wurdest geheilt");
      }
      return true;
    }
    if (cmd.getName().equalsIgnoreCase("feed"))
    {
      if ((p.hasPermission("testplugin.feed")) && 
        (args.length == 0))
      {
        p.setFoodLevel(20);
        p.sendMessage("§aDu wurdest gefüttert");
      }
      return true;
    }
    
    
    
    {
  

if (cmd.getName().equalsIgnoreCase("essen"))
{
    if (p.hasPermission("testplugin.essen"))
    {
            if(args.length == 1)
            {
                    Player p2 = getServer().getPlayer(args[0]);
                    ItemStack sword = new ItemStack(Material.STONE_SWORD, 1);
                    sword.addEnchantment(Enchantment.KNOCKBACK, 1);
                    p2.getInventory().addItem(new ItemStack (260, 5));
                    p2.getInventory().addItem(new ItemStack (357, 5));
                    p2.getInventory().addItem(new ItemStack (366, 3));
                    p2.getInventory().addItem(new ItemStack (354, 1));
                   
                    p2.sendMessage("§2Du hast von " + ChatColor.GREEN + p.getName() + " §2ein Essenspack erhalten!");
                    p.sendMessage("§2Du hast dem Spieler " + ChatColor.GREEN + p2.getName() + "§2 ein Essenspack gegeben!");
            }
            else if(args.length > 1)
            {
                    p.sendMessage("Ungueltiger Parameter!");
            }
            else
            {
                    p.getInventory().addItem(new ItemStack (322, 3));
                    p.getInventory().addItem(new ItemStack (260, 5));
                    p.getInventory().addItem(new ItemStack (357, 5));
                    p.getInventory().addItem(new ItemStack (366, 3));
                    p.getInventory().addItem(new ItemStack (354, 1));

                    p.sendMessage("§2Du hast dir ein Essenspack gegeben");
            }      
    }
}
    

    {
    
    if (cmd.getName().equalsIgnoreCase("tag"))
    {
      if ((p.hasPermission("system.tag")) && 
        (args.length == 0))
      {
        p.getWorld().setTime(0L);
        p.sendMessage("§6Die Zeit §6wurde auf §aTag gestellt!");
      }
      return true;
    }
    if (cmd.getName().equalsIgnoreCase("skype"))
    {
      if ((p.hasPermission("testplugin.feed")) && 
        (args.length == 0))
      {
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("§7[]===========] §bSkype §7[===========[]");
        p.sendMessage("");
        p.sendMessage("§7MinePlaysMc: §cMineflippr2000");
        p.sendMessage("");
        p.sendMessage("§7[]===========] §bSkype §7[===========[]");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
        p.sendMessage("");
     
        
      }
      return true;
    }
    
  
  if (cmd.getName().equalsIgnoreCase("test"))
  {
    if ((p.hasPermission("testplugin.feed")) && 
      (args.length == 0))
    {
      p.sendMessage("hay");;
      p.sendMessage("§aDu wurdest gefüttert");
    }
    return true;
  }
    
    
    
    
    
    
       
    
    if (cmd.getName().equalsIgnoreCase("ts"))
    {
      if (p.hasPermission(""))
      {
        
        {
          p.sendMessage("§7[]===========] §6TeamSpeak §7[===========[]");
          p.sendMessage("");
          p.sendMessage("§7IP: §cSkyMoon.eu");
          p.sendMessage("");
          p.sendMessage("§7[]===========] §6TeamSpeak §7[===========[]");
      }	
         return true;
      }
          {
         
          }
    }
         return false;
       }  
       }
     }
public static Plugin getInstance() {
	// TODO Auto-generated method stub
	return null;
}
   }