void print_dequeue(int (*f)(kolejka)){
	kolejka *queue;
	int k = f(&queue);
	if(k == -250){
		printf("niedomiar");
	}
	else{
		printf("%d\n", k);
	}
}