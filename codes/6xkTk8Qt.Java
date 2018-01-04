			if(myUnit.isLoaded() == true && myUnits.contains(myUnit) == true){
					int index = myUnits.indexOf(myUnit);
					myUnits.remove(index);
					System.out.println("Removing:" + myUnit.toString() + " from currrent militray units with id of : " + myUnit.getID());
			}