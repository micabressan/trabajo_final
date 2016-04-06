#include <stdio.h>
void line(int x0, int y0, int x1, int y1, int r, int g, int b) {
	int dx = abs(x1-x0), sx = x0<x1 ? 1 : -1;
	int dy = abs(y1-y0), sy = y0<y1 ? 1 : -1;
	int err = (dx>dy ? dx : -dy)/2, e2;

	for(;;){
		printf("add %d %d %d %d %d\n", x0, y0, r, g, b); 
		if (x0==x1 && y0==y1) break;	
		e2 = err;
		if (e2 >-dx) { err -= dy; x0 += sx; }
		if (e2 < dy) { err += dx; y0 += sy; }	
	}

}

void drawGrid(int iX, int iY, int height, int width, int spacing){
	int x = 0;
	int y = 0;
	while (y != height){
		line(iX, iY + y , width, iY + y, 0, 255, 0); 
		y += spacing;	
	}
	while (x != width){
		line(iX + x, iY , iX + x, height, 255, 0, 0); 
		x += spacing;	
	}
	printf("%d", x); 
}

int main(){
	drawGrid(0, 0, 640, 480, 10);
        return 0;
}