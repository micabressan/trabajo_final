#include <stdio.h>

main() {
   int medidas,nmagico,suma,estado;

   printf("Escriba el tamaÃ±o N de tabla (genera N x N): ");
   scanf("%d", &medidas);
   int tabla[medidas][medidas];
   printf("Escriba el nÃºmero mÃ¡gico a comprobar: ");
   scanf("%d", &nmagico);

   int i,j;
   for (i=0;i<medidas;i++) {
      for (j=0;j<medidas;j++) {
         printf("Introduzca valor para posiciÃ³n [%d] x [%d]: ", i+1,j+1);
         scanf("%d", &tabla[i][j]);
      }
   }

// todas las filas
// todas las columnas
// diagonal 1
// diagonal 2

   estado = 1;			// "True"
   suma = 0;
   /* Revisa filas */
   for (i=0;i<medidas;i++) {
      for (j=0;j<medidas;j++) {
         suma += tabla[i][j];
      }
   }
   if (suma != nmagico * medidas) {
      estado = 0;
   }
   suma = 0;
   if (estado == 1) {
      /* Revisa columnas */
      for (i=0;i<medidas;i++) {
         for (j=0;j<medidas;j++) {
            suma += tabla[j][i];
         }
      }
      if (suma != nmagico * medidas) {
         estado = 0;
      }
   }

   suma = 0;
   if (estado == 1) {
      /* Revisa diagonal 1 */
      for (i=0;i<medidas;i++) {
         suma += tabla[i][i];
      }
      if (suma != nmagico) {
         estado = 0;
      }
   }


   suma = 0;
   j = (medidas-1);
   if (estado == 1) {
      /* Revisa diagonal 2 */
      for (i=0;i<medidas;i++) {
         suma += tabla[i][j];
         j -= 1;
      }
      if (suma != nmagico) {
         estado = 0;
      }
   }
   if (estado == 1) {
      printf("Correcto\n");
   }else{
      printf("Incorrecto\n");
   }
}