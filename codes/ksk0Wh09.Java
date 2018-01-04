int[][] instructions = new int[][]
			{
					//row 1
				    {1,0,0,-3,1,0},
				    //row 2
				    {1,0,0,-2,1,0},
				    //row 3
				    {1,0,0,-1,1,0},
				    //row 4
				    {1,0,0,0,1,0},
				    //row 5
				    {1,0,0,1,1,0},
				    //row 6
				    {1,0,0,2,1,0},
				    //row 7
				    {1,0,0,3,1,0},
			};
			
					
			                          
			
			
			Double d = mc.thePlayer.posX, d1 = mc.thePlayer.posY, d2 = mc.thePlayer.posZ;
			int x = d.intValue() - 1;
			int y = d1.intValue() - 2;
			int z = d2.intValue() - 3;
			int currentItem = 0;
			
			 for(currentItem = 0; currentItem <= instructions.length; currentItem++)
             {
				 
				 try
				 {
                     if(instructions[currentItem][0] == 0){
                             //destroy block
                     }
                     if(instructions[currentItem][0] == 1){
                             mc.playerController.sendPlaceBlock(mc.thePlayer, mc.theWorld, mc.thePlayer.getCurrentEquippedItem(), x+instructions[currentItem][1], y+instructions[currentItem][2], z+instructions[currentItem][3], instructions[currentItem][4]);
                     }
				 }
				 catch(Exception e)
				 {
					 
				 }
                    
                                                            
             }