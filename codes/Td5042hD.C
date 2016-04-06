#include <stdio.h>

int provera(char *c);

void main(){
	int br=0, i=0, ukbr=0, procenat;
	char *c, s[255];

	fgets(s, 255, stdin);

	c=s;

	while((*c)!='\n'){
		if(provera(c)) br++;
		else printf("%c", *c);
		if(*c==' ') ukbr++;
	     c++;
	}
	
	
	
	printf("\n%d%%\n", (br/ukbr)*100);
}

int provera(char *c)
{
	if(*c>='A' && *c<='Z')
	{
		c++;
		if(*c=='@')
		{
			
			if(*c>='0' && *c<='9')
			{
	
				while(*c>='0' && *c<='9')
				{
					c++;
				}
				if(*c>='A' && *c<='Z') return 1;
				else return 0;
			}
			else return 0;
		}
		else return 0;	
	}
	else return 0;
}