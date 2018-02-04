
//prototipo da função move
void movePou (int *i, int *j, int dir, tPou* bichinho);

/*Objetivo: função que movimente o bichinho pelo tabuleiro, podendo ser para direita, para esquerda, para cima e para baixo.
lembrando que quando atingir o limite do tabuleiro ele deve se mover em sentido contrario.
A função assume o seguite menu de movimentos:
1 - anda para a direita
2 - anda para a esquerda 
3 - anda para cima 
4 - anda para baixo
essa função também incrementa a idade do bichinho virtual a cada movimento e diminui sua energia a cada movimento de acordo com seu sexo
*/
void movePou (int *i, int *j, int dir, tPou* bichinho) {
  
	//declaração de variaveis
	int contIdade = 0;	
	
 	//direção: andar para direita
  	if (dir == 1) {

    		(*j)++;
    	
		//verificando o limite do tabuleiro a direita
    		if (*j == 99) {
      			*j = 98;
    		}
 	}
  	//direção: andar para esquerda
  	else if (dir == 2) {

		(*j)--;
	
		//verificando o limite do tabuleiro a esquerda 
    		if (*j == 0) {
      			*j = 1;
    		}
  	}
  	//direção: andar para cima
  	else if (dir == 3) {
  	
    		(*i)--;
		//verificando o limite do tabuleiro em cima
    		if (*i == 0) {
      			*i = 1;
    		}
  	}
  
  	//direção: andar para baixo
  	else if (dir == 4) {

    		(*i)++;
	
		//verificando o limite do tabuleiro em baixo
   		if (*i == 99) {
      			*i = 98;
    		}
  	}

   	//incrementando a idade do bichinho a cada movimento
   	if(dir == 1 || dir == 2 || dir == 3 || dir == 4){
   		 contIdade = contIdade + 1;
   		 (*bichinho).idade = (*bichinho).idade + contIdade
   	}
   
   	//diminir a energia de acordo com sexo
   	//para macho
   	if(bichinho.sexo == 0){
   		if(dir == 1 || dir == 2 || dir == 3 || dir == 4){
   			(*bichinho).energia = (*bichinho).idade - 2;
   			
		}
   	}
   	//para femea
   	else if(bichinho.sexo == 1){
   		if(dir == 1 || dir == 2 || dir == 3 || dir == 4){
   			(*bichinho).energia = (*bichinho).energia - 1;
   			
		}
   	}
  return;
}