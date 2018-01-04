	public static ispisi(Cvor korijen, int depth){
		StringBuilder sb = new StringBuilder();
		for(int i =0; i<depth;i++){
			sb.append(" ");
		}
		System.out.println(sb.toString() + korijen.ispis);
		
		for(Cvor djete : korijen.getDjeca){
			ispisi(djete, depth+1);
		}
	}