public class TableauxDimensionSuperieure {
	
	public static int nbTrueDim2 (boolean [][] tab) {
		
		int nbvaleurstrue=0;
		
		for (int i=0; i < tab.length; i++) {
			
			for (int j=0; j < tab[i].length; j++) {
				
				if (tab[i][j]==true) {
					
					nbvaleurstrue++;
				}
				
			}
			
		}
		
		return nbvaleurstrue;
		
	}
	
	public static int nbTrueDim4 (boolean [][][][] tab) {
		
		int nbvaleurstrue=0;
		
		for (int i=0; i < tab.length; i++) {
			
			for (int j=0; j < tab[i].length; j++) {
				
				for (int k=0; k < tab[i][j].length; k++) {
					
					for (int l=0; l < tab[i][j][k].length; l++) {
						
						if (tab[i][j][k][l]==true) {
							
							nbvaleurstrue++;
							
						}
						
					}
					
				}
			}
			
		}
		
		return nbvaleurstrue;
		
	}
	
	
	public static boolean estPresentDim2 (int [][] tab, int val) {
		
		boolean present=false;
		
		for (int i=0; i < tab.length; i++) {
			
			for (int j=0; j < tab[i].length; j++) {
				
				if (tab[i][j]==val) {
					
					present=true;
					
				}
				
			}
			
		}
		
		return present;
		
	}
	
	
	public static boolean estPresentDim4 (int [][][][] tab, int val) {
		
		boolean present=false;
		
		for (int i=0; i < tab.length; i++) {
			
			for (int j=0; j < tab[i].length; j++) {
				
				for (int k=0; j < tab[i][j].length; j++) {
					
					for (int l=0; j < tab[i][j][k].length; j++) {
				
						if (tab[i][j][k][l]==val) {
					
							present=true;
							
						}
						
					}	
					
				}
				
			}
			
		}
		
		return present;
		
	}
	
	
	public static void mettreLesNégatifsàZéroDim2 (int [][] tab) {
		
		for (int i=0; i < tab.length; i++) {
			
			for (int j=0; j < tab[i].length; j++) {
				
				if (tab[i][j] < 0) {
					
					tab[i][j]=0;
					
				}
				
			}	
				
		}
		
	}
	
	
	public static void mettreLesNégatifsàZéroDim4 (int [][][][] tab) {
		
		for (int i=0; i < tab.length; i++) {
			
			for (int j=0; j < tab[i].length; j++) {
				
				for (int k=0; k < tab[i][j].length; k++) {
					
					for (int l=0; l < tab[i][j][k].length; l++) {	
				
						if (tab[i][j][k][l] < 0) {
					
							tab[i][j][k][l]=0;
					
						}
						
					}	
					
				}
				
			}
		
		}
		
	}
	
	public static int [] sommesColonnes (int [][] tab) {
		
		int [] tabvide = new int [0];
		
		if (tab.length !=0) {
			
			int [] tab2 = new int [tab[0].length];
		
			for (int i=0; i < tab.length; i++) {
			
				for (int j=0; j < tab[i].length; j++) {
				
				tab2[j]+= tab[i][j];
				
				}
			
			}	
		
		return tab2;
		
		}
		
		else {
			
			return tabvide;
		
		}
	
	}
	
	public static int [] nbzero (int [][] tab) {
		
		int [] tabvide = new int [0];
		
		if (tab.length !=0) {
			
			int [] tab2 = new int [tab[0].length];
		
			for (int i=0; i < tab.length; i++) {
			
				for (int j=0; j < tab[i].length; j++) {
				
					if (tab[i][j]==0) {
						
						tab2[j]++;
						
					}
				
				}
			
			}	
		
		return tab2;
		
		}
		
		else {
			
			return tabvide;
		
		}
	
	}
	
	public static boolean [] indiquevalzero (int [][] tab) {
		
		boolean [] tabvide = new boolean [0];
		
		if (tab.length !=0) {
			
			boolean [] tab2 = new boolean [tab[0].length];
		
			for (int i=0; i < tab.length; i++) {
			
				for (int j=0; j < tab[i].length; j++) {
				
					if (tab[i][j]==0) {
						
						tab2[j]=true;
						
					}
				
				}
			
			}	
		
		return tab2;
		
		}
		
		else {
			
			return tabvide;
		
		}
	
	}
		
}