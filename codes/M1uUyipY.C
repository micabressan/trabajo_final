#include <stdio.h>

	extern int wyrazenie(int n); /* external function declaration */

	int wyrazenie(int n);	 /* function prototype */
	
	typedef int bool;
	#define TRUE  1
	#define FALSE 0

	float a=10;
	int n;
	//To powinno dać 3628800
	

	char b[1];

	int main()
	{
		int i;
		char c;
		bool valid = TRUE;
		bool repeat = TRUE;
		
		while(repeat)
		{
			valid = TRUE;
		
		
			for (i = 0; i < sizeof(b); i++)
			{
	    		b[i] = 'k';
			}
		
			scanf("%1s", &b);
			while(1)   
        	{          
            	c = getchar();
            	
            	if (c == ' ' || c == '\n' || c == EOF) 
				{
					
					break;
				}
				else valid = FALSE;
				
				
        	}
        
        		if(valid == FALSE)
				{
					printf("%s\n", "Nieprawidlowe dane. Podaj liczbe nie wieksza niz 9");
			
				}
				else
				{
			
			
		
		
		
		
		
					for (i = 0; i < sizeof(b); i++)
					{
	    				if (!isdigit(b[i]))
	    				{
	        				valid = FALSE;
	        				break;
	    				}
					}
					if(valid == TRUE)
					{
		
						n = atoi(b);	
						printf("%ld\n", wyrazenie(n));
			
					}
					else
					{
						printf("%s\n", "Nieprawidlowe dane. Podaj liczbe nie wieksza niz 9");
					
					}
					
				}
		}
			
		getchar();
		
		
		return 0;
	}