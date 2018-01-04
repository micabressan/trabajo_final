#include <stdio.h>
#include <stdlib.h>

int somador(int x, int y );
int diminui(int x, int y );
int dividi(int x, int y );
int multiplica(int x, int y );


main(){
int num;
int digitar,escolher,calcsoma,calcdiminui,calcdi,calcmulti,saida;
printf("******");
printf("********Calculadora Matematica*******\n");


            do{
	printf("1> Para somar\n");
 printf("2> para diminuir\n");
  printf("3> para dividir\n");
   printf("4> para multiplicar\n");
    printf("0> para sair\n");		
     scanf("%d",&num);
        if(num!=0){
    
printf("Digite o calculo escolhido\n");

     scanf("%d",&digitar);
     scanf("%d",&escolher);
 
 }

            if(num==1)        {
      calcsoma=somador(digitar,escolher);	
      printf("o calculo eh %d+%d=%d\n",digitar,escolher,calcsoma);
    

}		
           else if(num==2){
     calcdiminui=diminui(digitar,escolher);	
 printf("o calculo eh %d-%d=%d\n",digitar,escolher,calcdiminui);
  

}	
          else if(num==3){
         calcdi=dividi(digitar,escolher);
       printf("o calculo eh %d/%d=%d\n",digitar,escolher,calcdi);
 

}
          else if(num==4){
       calcmulti=multiplica(digitar,escolher);
     printf("o calculo eh %d*%d=%d\n",digitar,escolher,calcmulti);
     

}
         else{
         printf("FIM DO PROGRAMA");

		
}

}    while (num!=0);

      return 0;
}

int somador(int x, int y ){
        int calc;
          return calc=x +y; 
	
}
int diminui(int x, int y ){
        int calc;
          return calc=x-y; 
	
}
int dividi(int x, int y ){
      int calc;
         return calc=x/y; 
	
}
int multiplica(int x, int y ){
       int calc;
        return calc=x*y; 
	
}