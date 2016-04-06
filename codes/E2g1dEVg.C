#include<stdio.h>
#define MAXSIZE 100
void qinsert(int);
void qdelete();
void display();
int front=0,rear=-1;
int Q[MAXSIZE];
void qinsert(int item)
{
    if (rear==MAXSIZE-1)
     {
	printf("\n\nOVERFLOW");
	return;
	}
    Q[++rear]=item;
}
void qdelete()
{
    int item;
    if (front-rear==1)
    {
        printf("\n\nUNDERFLOW");
        return;
    }
    item=Q[front++];
    printf("\n\nThe item deleted : %d",item);
}
void display()
{
    int i;
    if (front-rear==1)
        printf("\n\nQueue Empty!");
    else
    {
        printf("\n\n");
        for(i=front;i<=rear;i++)
            printf("%d ",Q[i]);
    }
}
int main()
{
    int c=1,x,i;
    while(c!=4)
    {
        printf("\n\nEnter 1 to insert.\nEnter 2 to delete.\nEnter 3 to display.\nEnter 4 to exit.\nEnter your choice : ");
        scanf("%d",&c);
        switch(c)
        {
            case 1:printf("\n\nEnter item to insert in queue : ");
                    scanf("%d",&x);
                    qinsert(x);
                    break;
            case 2: qdelete();
                    break;
            case 3: display();
                    break;
            case 4:exit(0);
            default:printf("\n\nWrong Choice !");
        }
    }
    return 0;
}