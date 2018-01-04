//		  while(true){
//			  System.out.println();
//			  if(response.compareTo("board")==0)
//			  {myboard = new Board(state);break;}
//		  } 
		  //gamestarts
		  response = "";
		  out.println("rdy");
		  out.flush();
		  while(response.compareTo("")==0){System.out.println(" ");}
		  
		  if(response.compareTo("FirstTurn")==0)
			  state.changeState();
		  
			  
		  
		  response = "";
		  
//		  String thread =""; 
//		  int x = 0; 
//		  int y = 0; 
//		  line = " ";