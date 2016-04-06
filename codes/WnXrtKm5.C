#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "cab202_graphics.h"
#include "cab202_timers.h"

//--------------------------------------------------------------------------
// Declare constants

#define OUTER_PERCENT (90)
#define NOMINAL_WIDTH (6)
#define DEFAULT_P (10)

//--------------------------------------------------------------------------
// Declare helper functions.

double p_norm( double x, double y, double p );

void get_racetrack_params( 
	int *x0, int *xr_outer, int *xr_inner, 
	int *y0, int *yr_outer, int *yr_inner, 
	double *p );

void get_start_pos( int *start_x, int *start_y );

//--------------------------------------------------------------------------
// Implement game.

bool inside_ellipse( double x, double y, double x0, double y0, double xr, double yr, double p ) {
	
	double pnorm = p_norm(((x - x0) / xr), ((y - y0) / yr), p);
			
	if (pnorm <= 1) { 
		return true;
	}
	else return false;
}

bool on_racetrack( int x, int y ) {

	double x0 = screen_width() / 2;
	double xr_outer = (OUTER_PERCENT * (screen_width() / 2)) / 100;
	double xr_inner = xr_outer - NOMINAL_WIDTH;

	double y0 = screen_height() / 2;
	double yr_outer = (OUTER_PERCENT * (screen_height() / 2)) / 100;
	double yr_inner = yr_outer - NOMINAL_WIDTH;

	double p = DEFAULT_P;


	if ((inside_ellipse( x, y, x0, y0, xr_outer, yr_outer, p )) && 
		(!(inside_ellipse( x, y, x0, y0, xr_inner, yr_inner, p )))) {
		return true;
	}
	else return false;
}

void draw_racetrack() {
	//y axis loop
	for (int y = 0; y < screen_height(); y++) {
		//x axis loop
		for (int x = 0; x < screen_width(); x++) {
			if (!(on_racetrack(x, y))) {
				draw_char(x, y, '!');
			}
		}
	}
}

void draw_zombie( int x, int y, bool zombie_alive ) {
	if ( zombie_alive ) {
		draw_char(x, y, 'Z');
	}
	else {
		draw_char(x, y, 'X');
	}
}

void update_view( int zombie_x, int zombie_y, bool zombie_alive ) {
	clear_screen();
	draw_racetrack();
	draw_zombie(zombie_x, zombie_y, zombie_alive);
	show_screen();
}

void zombie_racer( int start_x, int start_y ) {
	int x = start_x;
	int y = start_y;
	int dir = 0; // Start facing North.

	bool alive = on_racetrack( x, y );
	update_view( x, y, alive );
	int key = wait_char( );

	while ( key != 'q' && key >= 0 && alive ) {
		if ( key == '1') {
			//Veer Left

			if (dir == 2) {
				//If dir == East: Go North East
				//North East
				x += 1;
				y -= 1;
				dir = 0;
			} 
			else if (dir == 4) {
				//If dir == South: Go South East
				//South East
				x += 1;
				y += 1;
				dir = 2;
			}
			else if (dir == 6) {
				//If dir == West: Go South West
				//South West
				x -= 1;
				y += 1;
				dir = 4;
			}
			else if (dir == 0) {
				//If dir == North: Go North West
				//North West
				x -= 1;
				y -= 1;
				dir = 6;
			}
		}
		else if( key == '3' ) {
			//Veer Right

			if (dir == 4) {
				//If dir == South: Go South West
				//South West
				x -= 1;
				y += 1;
				dir = 6;
			}
			else if (dir == 2) {
				//If dir == East: Go South East
				//South East
				x += 1;
				y += 1;
				dir = 4;
			} 
			else if (dir == 0) {
				//If dir == North: Go North East
				//North East
				x += 1;
				y -= 1;
				dir = 2;
			}
			else if (dir == 6) {
				//If dir == West: Go North West
				//North West
				x -= 1;
				y -= 1;
				dir = 0;
			}
		}
		else {
			if (dir == 0) y -= 1; //North
			else if (dir == 2) x += 1; //East
			else if (dir == 4) y += 1; //South
			else if (dir == 6) x -= 1; //West
		}
		
		alive = on_racetrack( x, y );
		update_view( x, y, alive );
		timer_pause( 100 );
		key = wait_char( );
	}
}

// -------------------------------------------------------------------------

int main( void ) {
	srand( time( NULL ) );
	setup_screen();

	int start_x;
	int start_y;

	get_start_pos( &start_x, &start_y );
	zombie_racer( start_x, start_y );

	cleanup_screen();
	return 0;
}

//--------------------------------------------------------------------------
// Helper function implementations.

void get_start_pos( int *start_x, int *start_y ) {
	// Get the geometry of the race track/
	int x0, y0, xr_outer, yr_outer, xr_inner, yr_inner;
	double p;
	get_racetrack_params( &x0, &xr_outer, &xr_inner, &y0, &yr_outer, &yr_inner, &p );

	// Start at the left, close to the middle of the track. 
	*start_x = x0 - xr_outer + ( xr_outer - xr_inner ) / 2;
	*start_y = y0;
}

double p_norm( double x, double y, double p ) {
	// Error if bad input.
	if ( isinf( x ) || isinf( y ) || p == 0 ) {
		fprintf( stderr, "Illegal arguments in p_norm: x = %f, y = %f, p = %f\n", x, y, p );
		abort();
	}

	// Compute p-norm(x,y,p)
	double t1 = fabs( x );
	double t2 = fabs( y );
	return pow( pow( t1, p ) + pow( t2, p ), 1 / p );
}

void get_racetrack_params(
	int *x0, int *xr_outer, int *xr_inner,
	int *y0, int *yr_outer, int *yr_inner,
	double *p
) {
	(*x0) = screen_width() / 2;
	(*xr_outer) = OUTER_PERCENT * (screen_width() / 2) / 100;
	(*xr_inner) = (*xr_outer) - NOMINAL_WIDTH;

	(*y0) = screen_height() / 2;
	(*yr_outer) = OUTER_PERCENT * (screen_height() / 2) / 100;
	(*yr_inner) = (*yr_outer) - NOMINAL_WIDTH;

	(*p) = DEFAULT_P;
}