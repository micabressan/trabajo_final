# include <stdio.h>
# include <math.h>
int main()
{	
system("cls"); /*Löscht den Screen vor Ausführung des Programms	*/

int i=0, w;	

	for (i=0; i<20; i++)	
	{		
		w = rand() % 6;	//nicht nochmal Deklariren hab int vor w weggemacht war int w = ....
		printf("Die Zahl ist %d\n",w);
		i++;	
			
		
	}
	system("Pause");	//Darf micht in die Schleife sonst macht er praktisch immer pause 
	return 0;	
}