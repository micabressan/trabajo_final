#include<stdio.h>
#include<string.h>
#include<math.h>
#include<stdlib.h>
int main()
{
    int t,l,i,j,k,x,p,q,c;
    char s[1000],s1[1000];
    scanf("%d",&t);
    for(i=1;i<=t;i++)
    {
        c=0;
        fflush(stdin);
        scanf("%s",s);
        l=strlen(s);
        k=0;
        for(j=l-1;j>=0;j--)
        {
            s1[k]=s[j];
            k++;
        }
        s1[k]='\0';
        for(x=1;x<l;x++)
        {
            p=s[x]-s[x-1];
            q=s1[x]-s1[x-1];
            if(p<0)
                p=p/(-1);
            if(q<0)
                q=q/(-1);
            if(p!=q)
            {
                c=1;
                break;
            }
        }
        if(c==1)
            printf("Not Funny\n");
        else
            printf("Funny\n");
    }
    return 0;
}