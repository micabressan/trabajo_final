	int[][] instructions = new int[][]
		    {
				//begin row 1
				{1,1,0,-3,1,0},
				{1,1,0,0,1,0},
				{1,1,0,1,1,0},
				{1,1,0,2,1,0},
				{1,1,0,3,1,0},
				//end row 1
				//begin row 2
				{1,1,1,-3,1,0},
				{1,1,1,-0,1,0},
				//end row 2
				//begin row 3
				{1,1,2,-3,1,0},
				{1,1,2,-0,1,0},
				//end row 3
				//begin row 4 (blockface)
				{1,1,3,-3,1,0},
				{1,1,3,0,1,0},
					//row 4 blockface fuckery begin
				{1,1,3,-2,3,0},
				{1,1,3,-1,3,0},
				{1,1,3,3,2,0},
				{1,1,3,2,2,0},
				{1,1,3,1,2,0},
					//row 4 blockface fuckery begin end
				//end row 4
				//begin row 5
				{1,1,4,0,1,0},
				{1,1,4,3,1,0},
				//end row 5
				//begin row 6
				{1,1,5,0,1,0},
				{1,1,5,3,1,0},
				//end row 6
				//begin row 7
				{1,1,6,0,1,0},
				{1,1,6,3,1,0},
					//row 7 blockface fuckery begin
				{1,1,6,-1,2,0},
				{1,1,6,-2,2,0},
				{1,1,6,-3,2,0},
					//row 7 blockface fuckery end
				
				//end row 7
				//end figure
				
		    };