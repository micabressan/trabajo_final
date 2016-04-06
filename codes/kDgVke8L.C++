#ifndef GLOBAL_VARS_H_INCLUDED
#define GLOBAL_VARS_H_INCLUDED
 
 
SDL_Window* g_window = NULL;        //Game Window
SDL_Renderer* g_renderer = NULL;    //The window renderer
 
int view_SCREEN_WIDTH = 800;
int view_SCREEN_HEIGHT = 450;
 
bool g_init();   //Initializes SDL window
 
/*
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
}*/
 
#endif // GLOBAL_VARS_H_INCLUDED