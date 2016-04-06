#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

int main()
{
    int t,i,j,k,l1,l2,c;
    char s1[100000],s2[100000];
    scanf("%d",&t);
    for(i=1;i<=t;i++)
        {
        c=0;
        scanf("%s",s1);
        scanf("%s",s2);
        l1=strlen(s1);
        l2=strlen(s2);
        for(j=0;j<l1;j++)
            {
            for(k=0;k<l2;k++)
                {
                if(s1[j]==s2[k])
                    {
                    c=1;
                    j=l1;
                    break;
                }
            }
        }
        if(c==1)
            printf("YES\n");
        else
            printf("NO\n");
    }
    return 0;
}