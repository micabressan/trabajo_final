# include <stdio.h>
# include <math.h>

int main()
{
	system("cls"); /*Löscht den Screen vor Ausführung des Programms*/
	int i, w;
	for (i=1;i<20;i++)
	{	
	int w = rand() % 6+1;
	printf("Die Zahl ist %d\n",w);
	}
	
	system("Pause");
	return 0;	
}