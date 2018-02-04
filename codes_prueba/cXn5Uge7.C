main()
{
write_deq(dequeue());
}
queue.c
{
	void write_deq(int deq)
	{
		if(deq==0)
			printf("niedomiar");
		else
			printf("%d",dequeue_k())
	}
	int dequeue()
	{
		if(q.tail==q.head)
			return 0
		else
			return 1
	}
	int dequeue_k()
	{
		k = q->data[q->head];
		if(q->head == q->length-1)
		{
			q->head=1;
		}
		else
		{
			q->head = q->head+1;
		}
		return k;
	}
}