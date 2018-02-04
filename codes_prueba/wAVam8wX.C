#include<stdio.h>



int main()
{
	
	int n=0;
	
	printf("podaj liczbe elementow tablicy: ");
	scanf("%d",&n);

	int tab[n];

	for(int i=0;i<n;i++)
	{
		printf("podaj %d. element tablicy: ",i+1);
		scanf("%d",&tab[i]);
	}

	int max=tab[0],min=tab[0];

	for(int i=0;i<n;i++) 
	{
		
		if (max<tab[i])		
		{
			max=tab[i];
		}
		if (min>tab[i])
		{
			min=tab[i];
		}

	}
	
	printf("max to:%d\nmin to %d",max,min);


	return 0;

}