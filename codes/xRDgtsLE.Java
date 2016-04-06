@EventHandker
public void PlayerQuit(PlayerQuitEvent e){
      final Player p = e.getPlayer();
       e.setQuitMessage(ChatColor.AQUA+"Le joueur "+ChatColor.ITALIC+ChatColor.RED+p.getDisplayName()+ChatColor.AQUA+" a quitter la partie ("+online+"/24)");
         if(online < 12){

                  e.setQuitMessage(ChatColor.AQUA+"Il faut "+ChatColor.ITALIC+ChatColor.RED+"12"+ChatColor.AQUA+" joueurs pour lancer la partie");
}
 
         }