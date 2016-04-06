# include<stdio.h>

int main()
{
	char menu;
	system("CLS");
	do
	{
		printf("- b: fuer beenden\n");
		printf("- a: fuer anlegen\n");
		printf("- i: fuer loeschen\n");
		printf("- x: fuer aendern\n");
		printf("Eingabe: ");
		scanf("%c",&menu);
		fflush(stdin);
		if(menu=='b') 
		{
			printf("\nSie haben %c gedrueckt\n\n",menu);
			break;
		}
		printf("\nSie haben %c gedrueckt\n\n",menu);
	}
	while(menu=='a' || menu=='i' || menu=='x');

	
	system("pause");
	return 0;
}