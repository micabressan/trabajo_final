#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 
struct el
{
         double d;
         char c;
         int *i;
};
  
int main(void)
{
         struct el *p_struct;
  
         p_struct = (struct el *)malloc(sizeof(struct el));
         if (!p_struct)
               exit(-1);
  
         p_struct->d = 3.1415926525897936264;
         p_struct->c = '\0';
         p_struct->i = (int*)malloc(sizeof(int));
         if (!(p_struct->i))
                 exit(-1);
  
          printf("Struct elements: %lf %c %d", p_struct->d, p_struct->c, *p_struct->i);
  
          free(p_struct);
          return 0;
}