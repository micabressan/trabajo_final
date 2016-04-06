#include <stdio.h>
#include<string.h>
int main()
{
int n,j=0,i=1,k=0,c=0,m=0,s=0;
char a[100000],b[100000];
   scanf("%d",&n);
   for(i=1;i<=n;i++)
   {
       scanf("%s %s",a,b);

      k=strlen(a);
      c=strlen(b);
       for(j=0;j<k;j++)
       {
           for(m=0;m<c;m++)
           {
          if(a[j]==a[m])
               {
               s=1;
           }
       else
           {
               s=0;

           }

       }
       }
              if(s==1)
       {
           printf("YES");
       }
       else
       {

           printf("NO");
       }

        printf("\n");

   }
           return 0;
           }