	public void insert(E data){
		if(heap.length>size){
			heap[size]=data;
			size++;
			bubbleup();
		}else{doubleCapacity();insert(data);}
	}
	public void bubbleup(){
		if(size<=1){return;}
		boolean done=false;
		int current = size-1; 
		while(!done && current>=1){			
			int parent = (int) Math.floor((current-1)/2);
			if(heap[current].compareTo(heap[parent])<0){
				E temp = heap[parent];//parent
				heap[parent] = heap[current];//parent = child
				heap[current] = temp;//child = old parent
			}else{done = true;}
			current = parent;
		}
	}