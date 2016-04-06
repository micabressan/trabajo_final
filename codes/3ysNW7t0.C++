
//Using SDL and standard IO
#include <SDL.h>
#include <SDL_image.h>
#include <stdio.h>
#include <string>

//My Personal header files

#include "global_vars.h"

///*    Screen Properties
///*
///*    These properties determine the resolution for the game
///*    I'll try to use a viewport to display this to the screen.

const int SCREEN_WIDTH = 1600;
const int SCREEN_HEIGHT = 900;
const int SCREEN_FPS = 60;
const int SCREEN_TICK_PER_FRAME = 1000 / SCREEN_FPS;

///*    These determine the View resolution that the player will see in the window.

////Being placed in global_vars.h header file   ////
/*
int view_SCREEN_WIDTH = 800;
int view_SCREEN_HEIGHT = 450;

SDL_Window* g_window = NULL;        //Game Window
SDL_Renderer* g_renderer = NULL;    //The window renderer
//*/
////                                            ////

///*    Texture class,
///*
///*    for reference, stores image data to be used by the GPU

////Being placed in image_func.cpp              ////
/*
class ImageTexture
{
    public:

        ImageTexture();                         //Initialize Default Variables
        ~ImageTexture();                        //Deallocate memory

        bool loadImageFile(std::string path);   //Loads image from file path
        void free();                            //Deallocate's texture
        void render(int x, int y);              //Renders/Draws texture to coordinates on screen

        int getWidth();
        int getHeight();

    private:

        SDL_Texture* imgTexture;               //The image Texture

        int imgWidth;
        int imgHeight;

};

ImageTexture::ImageTexture()
{
    //Initialize
    imgTexture = NULL;
    imgWidth = 0;
    imgHeight = 0;
}

ImageTexture::~ImageTexture()
{
    free();     //Deallocate
}


bool ImageTexture::loadImageFile(std :: string path)
{
    free();                             //Get rid of existing Texture if it exists

    SDL_Texture* newTexture = NULL;     //Final Texture

    SDL_Surface* loadedSurface = IMG_Load(path.c_str());
    if (loadedSurface == NULL)
    {
        printf( "Unable to load image %s! SDL_image Error: %s\n", path.c_str(), IMG_GetError() );
    }
    else
    {
        //Create texture from surface pixels
        newTexture = SDL_CreateTextureFromSurface(g_renderer, loadedSurface);
        if (newTexture == NULL)
        {
            printf( "Unable to create texture from %s! SDL Error: %s\n", path.c_str(), SDL_GetError() );
        }
        else
        {
            //Get Image Dimensions
            imgWidth = loadedSurface->w;
            imgHeight = loadedSurface->h;
        }

        //Get rid of old loaded surface
        SDL_FreeSurface(loadedSurface);
    }
    //Return success
    imgTexture = newTexture;
    return imgTexture != NULL;
}

void ImageTexture::free()
{
    //This frees the texture if it still exists
    if (imgTexture != NULL)
    {
        SDL_DestroyTexture(imgTexture);
        imgTexture = NULL;
        imgHeight = 0;
        imgWidth = 0;
    }
}

void ImageTexture::render(int x, int y)
{
    //Set rendering space and render to screen
	SDL_Rect renderQuad = { x, y, imgWidth, imgHeight };
	SDL_RenderCopy( g_renderer, imgTexture, NULL, &renderQuad );
}

int ImageTexture::getWidth()
{
    return imgWidth;
}

int ImageTexture::getHeight()
{
    return imgHeight;
}


//Initializations
bool g_init();   //Initializes SDL window




//Declarations
bool g_init()   //Default initialization for the SDL Game Window
{
    //Initialization flag
	bool success = true;

	//Initialize SDL
	if( SDL_Init( SDL_INIT_VIDEO ) < 0 )
	{
		printf( "SDL could not initialize! %s\n", SDL_GetError() );
		success = false;
	}
	else
	{
	    //Create window
		g_window = SDL_CreateWindow( "EllenTrigger Version 0.1", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, view_SCREEN_WIDTH, view_SCREEN_HEIGHT, SDL_WINDOW_SHOWN );
		if( g_window == NULL )
		{
			printf( "Window could not be created! SDL Error: %s\n", SDL_GetError() );
			success = false;
		}
		else
        {
            //Create Renderer for window.
            g_renderer = SDL_CreateRenderer(g_window, -1, SDL_RENDERER_ACCELERATED);
            if (g_renderer == NULL)
            {
                printf( "Renderer could not be created! SDL Error: %s\n", SDL_GetError() );
				success = false;
            }
            else
            {
                //Initialize renderer color to white
				SDL_SetRenderDrawColor( g_renderer, 0xFF, 0xFF, 0xFF, 0xFF );

				//Initialize PNG Loading
				int imgFlags = IMG_INIT_PNG;
				if( !( IMG_Init( imgFlags ) & imgFlags ) )
				{
					printf( "SDL_image could not initialize! SDL_image Error: %s\n", IMG_GetError() );
					success = false;
				}
            }
        }
	}

	return success;
}
//*/
////                                            ////

int main( int argc, char* args[] )
{
    //Initialize the Game Window
    //g_init();

    //SDL_Delay(1000);

    //Quit SDL subsystems
	//SDL_Quit();

    return 0;
}