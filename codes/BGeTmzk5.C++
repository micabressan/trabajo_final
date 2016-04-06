




#include "stdafx.h"
#include <gl\GL.h>
#include <gl\GLU.h>
#include "GL\glext.h"
#include "GL\wglext.h"

#include <stdio.h>



//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST

#include <cstdio>
#include <cmath>
#include <algorithm>

#define EPS     1e-18

class CVector2
{
public:
	double x, y;
	CVector2( double _x = 0.0f, double _y = 0.0f ) { x = _x; y = _y; }
	CVector2 operator +( const CVector2 &v ) { return CVector2( x + v.x, y + v.y ); }
	CVector2 operator -( const CVector2 &v ) { return CVector2( x - v.x, y - v.y ); }
	CVector2 operator -( ) { return CVector2( -x, -y ); }
	double SqrLength() { return x * x + y * y; }
	void Read( FILE *fin ) { fscanf( fin, "%lf %lf", &x, &y ); }
	static double DotProduct( CVector2 v1, CVector2 v2 ) { return v1.x * v2.x + v1.y * v2.y; }
};

bool IsPointOnSegment( CVector2 v1, CVector2 v2, CVector2 p )
{
	if( CVector2::DotProduct( v2 - v1, p - v1 ) > 0.0f &&
		CVector2::DotProduct( v1 - v2, p - v2 ) > 0.0f )
		return true;
	return false;
}

bool GetIntersection( CVector2 v1_begin, CVector2 v1_end,
					  CVector2 v2_begin, CVector2 v2_end,
					  CVector2 *result )
{
	if( fabs( v2_begin.x - v2_end.x ) < EPS )
	{
		std::swap( v1_begin, v2_begin );
		std::swap( v1_end, v2_end );
	}
	if( fabs( v1_begin.x - v1_end.x ) < EPS )
	{
		if( fabs( v2_begin.x - v2_end.x ) < EPS )
			return false;

		result->x = v1_begin.x;
		result->y = v2_begin.y + ( v2_end.y - v2_begin.y ) *
			( ( result->x - v2_begin.x ) / ( v2_end.x - v2_begin.x ) );

		return IsPointOnSegment( v1_begin, v1_end, *result ) &&
			IsPointOnSegment( v2_begin, v2_end, *result );
	}

	double k1 = ( v1_end.y - v1_begin.y ) / ( v1_end.x - v1_begin.x );
	double k2 = ( v2_end.y - v2_begin.y ) / ( v2_end.x - v2_begin.x );

	if( fabs( k1 - k2 ) < EPS )
		return false;

	double b1 = v1_begin.y + ( v1_end.y - v1_begin.y ) *
		( 0 - v1_begin.x / ( v1_end.x - v1_begin.x ) );
	double b2 = v2_begin.y + ( v2_end.y - v2_begin.y ) *
		( 0 - v2_begin.x / ( v2_end.x - v2_begin.x ) );

	result->x = ( b2 - b1 ) / ( k1 - k2 );
	result->y = k1 * result->x + b1;

	return IsPointOnSegment( v1_begin, v1_end, *result ) &&
		IsPointOnSegment( v2_begin, v2_end, *result );
}
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST



bool fullscreen = false;

HDC hDC;
HGLRC hRC;
HWND hWnd;
HINSTANCE hInstance;

void GetCursorPos( int *x, int *y )
{
	POINT cursorpos;
	GetCursorPos( &cursorpos );
	ScreenToClient( hWnd, &cursorpos );
	*x = cursorpos.x;
	*y = cursorpos.y;
}

void DrawQuad( float x, float y, float w, float h )
{
	w /= 2.0f;
	h /= 2.0f;

	glTranslatef( x, y, 0 );

	glBegin( GL_QUADS );
	glVertex2f( -w, -h );
	glVertex2f( w, -h );
	glVertex2f( w, h );
	glVertex2f( -w, h );
	glEnd();

	glTranslatef( -x, -y, 0 );
}

class Quad
{
public:
	float x, y;
	float w, h;

	int lx, ly;

	bool isDrag;

	Quad( float _x, float _y, float _w, float _h )
	{
		x = _x;
		y = _y;
		w = _w;
		h = _h;

		isDrag = false;

		GetCursorPos( &lx, &ly );
	}

	void OnMouseDown()
	{
		if( IsMouseHover() )
			isDrag = true;
	}

	void OnMouseUp()
	{
		isDrag = false;
	}

	bool IsMouseHover()
	{
		int cx, cy;
		GetCursorPos( &cx, &cy );

		if( cx >= x - w / 2 && cy >= y - h / 2 &&
			cx <= x + w / 2 && cy <= y + h / 2 )
			return true;
		return false;
	}

	void Update()
	{
		int cx, cy;
		GetCursorPos( &cx, &cy );

		if( isDrag )
		{
			int offset_x = cx - lx;
			int offset_y = cy - ly;

			x += offset_x;
			y += offset_y;
		}

		lx = cx;
		ly = cy;
	}

	void Draw()
	{
		glColor3f( 1.0, 1.0, 1.0 );


		DrawQuad( x, y, w, h );
	}
} quad1( 10, 100, 20, 20 ), quad2( 10, 400, 20, 20 ), quad3( 10, 200, 20, 20 ), quad4( 100, 200, 20, 20 );






void Update()
{
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

	glLoadIdentity();

	quad1.Update();
	quad1.Draw();

	quad2.Update();
	quad2.Draw();

	quad3.Update();
	quad3.Draw();

	quad4.Update();
	quad4.Draw();

	CVector2 v1( quad1.x, quad1.y );
	CVector2 v2( quad2.x, quad2.y );
	CVector2 v3( quad3.x, quad3.y );
	CVector2 v4( quad4.x, quad4.y );

	glBegin( GL_LINES );
	glVertex2f( v1.x, v1.y );
	glVertex2f( v2.x, v2.y );
	glEnd();

	glBegin( GL_LINES );
	glVertex2f( v3.x, v3.y );
	glVertex2f( v4.x, v4.y );
	glEnd();

	CVector2 res;

	if( GetIntersection( v1, v2, v3, v4, &res ) )
	{
		glColor3f( 0, 0, 1 );
		DrawQuad( res.x, res.y, 20, 20 );
	}

	SwapBuffers( hDC );
}

LRESULT CALLBACK WndProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam );

void ResizeGLWindow( int W, int H )
{
	if( H == 0 )
		H = 1;
	glViewport( 0, 0, W, H );
	glMatrixMode( GL_PROJECTION );
	glLoadIdentity();

	gluOrtho2D( 0, W, H, 0 );

	//gluPerspective( 80.0f, (GLfloat)W/(GLfloat)H, 0.1f, 80980.0f );
	glMatrixMode( GL_MODELVIEW );
	glLoadIdentity();
}

void InitGL( void )
{
	glShadeModel( GL_SMOOTH );
	glClearColor( 1.0f, 0.0f, 0.0f, 0.0f );
	glClearDepth( 1.0f );
	glEnable( GL_DEPTH_TEST );
	glDepthFunc( GL_LEQUAL );
	glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );
	glEnable( GL_TEXTURE_2D );
	glShadeModel( GL_SMOOTH );

	PFNWGLSWAPINTERVALEXTPROC wglSwapIntervalEXT = NULL;
	wglSwapIntervalEXT = ( PFNWGLSWAPINTERVALEXTPROC )wglGetProcAddress( "wglSwapIntervalEXT" );
	wglSwapIntervalEXT = ( BOOL( WINAPI * )( int ) ) wglGetProcAddress( "wglSwapIntervalEXT" );
	wglSwapIntervalEXT( 0 );

}

void KillGLWindow( void )
{
	if( fullscreen )
	{
		ChangeDisplaySettings( NULL, 0 );
		ShowCursor( true );
	}
	wglMakeCurrent( NULL, NULL );
	wglDeleteContext( hRC );
	hRC = NULL;
	ReleaseDC( hWnd, hDC );
	DestroyWindow( hWnd );
	UnregisterClass( L"OpenGL", hInstance );
}

void CreateGLWindow( LPCWSTR title, int width, int height, int bits, bool fullscreenflag )
{
	GLuint PixelFormat;
	WNDCLASS wc;
	DWORD dwExStyle;
	DWORD dwStyle;
	RECT WindowRect;
	WindowRect.left = ( long )0;
	WindowRect.right = ( long )width;
	WindowRect.top = ( long )0;
	WindowRect.bottom = ( long )height;
	fullscreen = fullscreenflag;
	hInstance = GetModuleHandle( NULL );
	wc.style = CS_HREDRAW | CS_VREDRAW | CS_OWNDC;
	wc.lpfnWndProc = ( WNDPROC )WndProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	wc.hInstance = hInstance;
	wc.hIcon = LoadIcon( NULL, IDI_WINLOGO );
	wc.hCursor = LoadCursor( NULL, IDC_ARROW );
	wc.hbrBackground = NULL;
	wc.lpszMenuName = NULL;
	wc.lpszClassName = L"OpenGL";
	RegisterClass( &wc );
	//ShowCursor( false );
	if( fullscreen )
	{
		DEVMODE dmScreenSettings;
		memset( &dmScreenSettings, 0, sizeof( dmScreenSettings ) );
		dmScreenSettings.dmSize = sizeof( dmScreenSettings );
		dmScreenSettings.dmPelsWidth = width;
		dmScreenSettings.dmPelsHeight = height;
		dmScreenSettings.dmBitsPerPel = bits;
		dmScreenSettings.dmFields = DM_BITSPERPEL | DM_PELSWIDTH | DM_PELSHEIGHT;
		ChangeDisplaySettings( &dmScreenSettings, CDS_FULLSCREEN );
		dwExStyle = WS_EX_APPWINDOW;
		dwStyle = WS_POPUP;
	}
	else
	{
		dwExStyle = WS_EX_APPWINDOW | WS_EX_WINDOWEDGE;
		dwStyle = WS_OVERLAPPEDWINDOW;
	}
	AdjustWindowRectEx( &WindowRect, dwStyle, false, dwExStyle );
	hWnd = CreateWindowEx( dwExStyle, _T( "OpenGL" ), title, WS_CLIPSIBLINGS | WS_CLIPCHILDREN |
						   dwStyle, 0, 0, WindowRect.right - WindowRect.left, WindowRect.bottom - WindowRect.top, NULL, NULL, hInstance, NULL );
	static  PIXELFORMATDESCRIPTOR pfd =
	{
		sizeof( PIXELFORMATDESCRIPTOR ),
		1,
		PFD_DRAW_TO_WINDOW |
		PFD_SUPPORT_OPENGL |
		PFD_DOUBLEBUFFER,
		PFD_TYPE_RGBA,
		bits,
		0, 0, 0, 0, 0, 0,
		0,
		0,
		0,
		0, 0, 0, 0,
		32,
		0,
		0,
		PFD_MAIN_PLANE,
		0,
		0, 0, 0
	};
	hDC = GetDC( hWnd );
	PixelFormat = ChoosePixelFormat( hDC, &pfd );
	SetPixelFormat( hDC, PixelFormat, &pfd );
	hRC = wglCreateContext( hDC );
	wglMakeCurrent( hDC, hRC );
	ShowWindow( hWnd, SW_SHOW );
	SetForegroundWindow( hWnd );
	SetFocus( hWnd );
	ResizeGLWindow( width, height );
	InitGL();
}

int APIENTRY WinMain( HINSTANCE hInstance,
					  HINSTANCE hPrevInstance,
					  LPSTR     lpCmdLine,
					  int       nCmdShow )
{

	CreateGLWindow( L"Dima228", 1024, 768, 32, fullscreen );

	MSG msg;
	while( true )
	{
		if( PeekMessage( &msg, NULL, 0, 0, PM_REMOVE ) )
		{
			if( msg.message == WM_QUIT )
			{
				break;
			}
			else
			{
				TranslateMessage( &msg );
				DispatchMessage( &msg );
			}
		}
		else
		{
			Update();
		}
	}
	return msg.wParam;
}

LRESULT CALLBACK WndProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam )
{
	switch( message )
	{

		case WM_SYSCOMMAND:
		{
							  switch( wParam )
							  {
								  case SC_SCREENSAVE:
								  case SC_MONITORPOWER:
									  return 0;
							  }
							  break;
		}

		case WM_CLOSE:
		{
						 PostQuitMessage( 0 );
						 return 0;
		}
		case WM_SIZE:
		{
						ResizeGLWindow( LOWORD( lParam ), HIWORD( lParam ) );
						return true;
		}
		case WM_LBUTTONDOWN:
		{
							   quad1.OnMouseDown();
							   quad2.OnMouseDown();
							   quad3.OnMouseDown();
							   quad4.OnMouseDown();
							   break;
		}
		case WM_LBUTTONUP:
		{
							 quad1.OnMouseUp();
							 quad2.OnMouseUp();
							 quad3.OnMouseUp();
							 quad4.OnMouseUp();
							 break;
		}
	}

	return DefWindowProc( hWnd, message, wParam, lParam );
}