#include<stdio.h>

int main()
{

	int tab[8]={1,1,5,4,3,3,2,2};

	int l1=0,l2=0,l3=0,l4=0,l5=0;	

	for(int i=0;i<8;i++)
	{
		if(tab[i]==1)l1++;
		else if(tab[i]==2)l2++;
		else if(tab[i]==3)l3++;
		else if(tab[i]==4)l4++;
		else if(tab[i]==5)l5++;
	}	
			
	printf("l1=%d\nl2=%d\nl3=%d\nl4=%d\nl5=%d\n",l1,l2,l3,l4,l5);	
			

}