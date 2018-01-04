//tu sie plansza zaczełazr
Random rand = new Random();
    		int n = rand.nextInt(players.size()-1);
    		char c = (char) (n + '0');
    		line = in.readLine();
    		line="";
    		if(this.getName().compareTo("Thread-" + '1') ==0)
    		{
    			out.println("FirstTurn");
    			out.flush();
    		}
    		else
    		{
    			out.println("NotFirstTurn");
    			out.flush();
    		}

//tu jest

//    		 line = in.readLine();  // read line which client send
    		 
//    		 while(line.compareTo("exit")!=0)
//    		 {