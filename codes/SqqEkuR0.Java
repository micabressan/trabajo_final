public boolean distanceAway(Location loc2, Location loc1, int distance) {
	  if (loc1.getX() >= loc2.getX()-distance && loc1.getX() <= loc2.getX()-distance) { /* player in 50 block x radius */ 
		  if (loc1.getY() >= loc2.getY()-distance && loc1.getY() <= loc2.getY()-distance) {
			  return true;
		  }
		  
		  
	  }
      return false;
  }


if(distanceAway(event.getPlayer().getWorld().getSpawnLocation(), event.getPlayer().getLocation(), 50)){
	   System.out.println("called");
   }