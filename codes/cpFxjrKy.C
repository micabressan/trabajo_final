#include<stdio.h>



int main()
{	
	//wypelnianie tablicy	
	int n;
	printf("podaj liczbe elementow tablicy:");
	scanf("%d",&n);	

	int a[n];

	for(int i=0;i<n;i++)
	{	

		printf("podaj %d. element tablicy: ",i+1);
		scanf("%d",&a[i]);
	
	}
	//szukanie najwiekszej najmniejszej wartosci i miejsca
	int max=a[0],min=a[0],imax=0,imin=0;
	
	for(int i=0;i<n;i++)
	{
		if(max<a[i])
		{
			max=a[i];
			imax=i;
		}
		if(min>a[i])
		{
			min=a[i];
			imin=i;
		}
	}
	//sprawdznie
	for(int i=0;i<n;i++)
	{
		printf("---%d---",a[i]);
	}

		printf("\n");
	//zamiana
	printf("max:%d\nmin:%d\nimax:%d\nimin:%d\n",max,min,imax,imin);	
	
	a[imin]=max;
	a[imax]=min;


	
	//sprawdzenie
	for(int i=0;i<n;i++)
	{
		printf("---%d---",a[i]);
	}

		printf("\n");

	return 0;
}