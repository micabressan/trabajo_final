void write(Queue q)
{
	int i;
	if(q.head == q.tail)
		{
			printf("\n");
			return;
		}
	if(q.head>q.tail)
	{
		for(i=q.head;i<q.length;i++)
		{
			printf("%d ",q.data[i]);
		}
		for(i = 0; i<q.tail; i++)
		{
			printf("%d ",i);
		}
	}
	else
	{
		for(i=q.head;i<q.tail;i++)
		{
			printf("%d ",q.data[i]);
		}
	}
	printf("\n");
}