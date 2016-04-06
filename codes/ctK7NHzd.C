

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

 void main () {

char linija[101],*c,*c1;
int i=0,br,br1,br2;

scanf("%s",linija);

while(linija[i]!='\n') {

while(linija[i]!= '[') putchar(linija[i++]);

*c=linija[i+1];
br=atoi(c);


if(isdigit(linija[i+2])) {

*c1=linija[i+2];
br1=atoi(c1);
br2=br*10+br1;
i+=br2-1;
}

else i+=br-1;
}
linija[i]='\0';

}