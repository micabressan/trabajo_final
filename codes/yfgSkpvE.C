typedef struct{
	int x, y; // Coordenadas
	int xSpeed, ySpeed; // Velocidades
}OBJECT;

void main(){
	OBJECT o = {20, 20, 0, 0}; // Velocidades inicializadas em 0

    while(getch() != 27){
		if(toupper(getch() == 'W'){
			ySpeed = -1; // Já que o Y aumenta de baixo para cima
		}
		else if(toupper(getch() == 'S'){
			ySpeed = 1;
		}
		else if(toupper(getch() == 'A'){
			xSpeed = -1;
		}
		else if(toupper(getch() == 'D'){
			xSpeed = 1;
		}
	}

	return;
}