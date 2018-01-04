int DEQUEUE(kolejka *queue){
	int k;
	if(queue->head == queue->tail){
		return -250;
	}
	else{
		k = queue->data[queue->head];
		if(queue->head == queue->length){
			queue->head = 1;
		}
		else{
			queue->head = queue->head +1;
		}
		return k;
	}
}