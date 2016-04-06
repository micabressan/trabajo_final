#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>
#include <pthread.h>

#define BPP 4
#define DEPTH 32 

long *screenWidth;
long *screenHeight; 
long *framerate;

SDL_Surface *screen; 

void *initialiseSDL( ) { 

	
	if ( SDL_Init ( SDL_INIT_VIDEO ) != 0 ) { 
		printf( "Unable to initialize SDL: %s\n", SDL_GetError()); 
	       		  exit(1);
	}

	if (!(screen = SDL_SetVideoMode( (int)screenWidth , (int)screenHeight, DEPTH,
		  	  SDL_RESIZABLE|SDL_HWSURFACE ) ) ) 
	{
		 exit (1); 
	}

	if (screen == NULL) { 
		printf( "Unable to set video mode: %s\n", SDL_GetError() ); 
	       	exit (1); 
	}

	if ( SDL_LockSurface ( screen ) < 0 ) exit (1);

}

void setpixel (int x, int y, Uint8 r, Uint8 g, Uint8 b ) 
{ 
	Uint32 *pixmem32 ;
	Uint32 colour ;
	colour    = SDL_MapRGB(screen->format, r, g, b); 
	pixmem32  = (Uint32*) screen->pixels + y + x; 
	*pixmem32 = colour; 
}
void DrawScreen () { 
	int i = 0 ;  
	if ( SDL_MUSTLOCK ( screen ) )
	{ 
		if ( SDL_LockSurface ( screen ) < 0 ) 
			return; 
	}
	if ( SDL_MUSTLOCK ( screen ) ) SDL_UnlockSurface(screen);
	SDL_Flip ( screen ); 
}
int strToInt(char *string, long *integer){
	char *ptr;
	if (strcmp(string, "0") || (strcmp(string, "0\n"))){
		if (!(*integer = strtol(string, &ptr, 10))){
			return 1;
		}else{
			return 0; 
		}
	}else{ 
		*integer = 0;
		return 0;
	}
	
}
int add(char *array[10]){
	long temp[4];
	int i = 0;
	for (i; i != 4; i++){
		if (!(strcmp(array[i+1], "0" )) || !(strcmp(array[i+1], "0\n"))){
			temp[i] = 0;
		}
		else if (strToInt(array[i+1], &temp[i])){
			return 1;
		}
	}
	setpixel(temp[0], temp[1], temp[2], temp[3], temp[4] ); 
}
void *handle_stdin(void *empty){
	char *buffer[20];
	char *token;
	char *array[10];
	int x;
	while (1){
		fgets(buffer, sizeof(buffer), stdin);
		token=strtok(buffer, " ");
		x = 0;
		while(token){
			array[x++] = token;
			token = strtok(NULL, " ");
		}
		if (!(strcmp(array[0], "exit\n")) || !(strcmp(array[0], "exit"))){
			exit(0);
		}
		if (!(strcmp(array[0], "add\n")) || !(strcmp(array[0], "add"))){
			add(array);	
		}

	}
}

int main(){
	int mouseX, mouseY;
	framerate = 60;
	screenWidth = 640;
	screenHeight = 480;	

	printf("Canvas initialised at %dx%d with a framerate of %d.\n", screenWidth, screenHeight, framerate);
	initialiseSDL();
	int x = 0;
	char buffer[20];
	char*token;
	char*array[10];
	atexit(SDL_Quit);
	pthread_t thread0;

	pthread_create(&thread0, NULL, handle_stdin, NULL);

	while (1){
/*		SDL_PumpEvents();
		SDL_GetMouseState(&mouseX,&mouseY);
		printf("mouseX: %d\tmouseY%d\n", mouseX, mouseY); */
		DrawScreen(screen);
	}

	return 0;
}