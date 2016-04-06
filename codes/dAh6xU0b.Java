public boolean isBinMinHeap(){
		if(size>1){			
			for(int current=size-1, parent=(int) Math.floor((current-1)/2);
					current>=0;
					current--, parent = (int) Math.floor((current-1)/2)){		
				if(heap[current].compareTo(heap[parent])<0){
					//System.out.println("Indexes: child="+current+" vs parent="+parent+" ==> "+heap[current]+" vs "+heap[parent]+" = "+heap[current].compareTo(heap[parent]));
					return false;
				}
			}
		}		
		return true;
}