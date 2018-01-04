void dequeue(Queue *q)
{
	int k ;
	if(q->head == q->tail)
		printf("niedomiar\n");
	else
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
		printf("%d\n",k);
	}
}