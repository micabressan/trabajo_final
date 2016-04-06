#include <iostream>
using namespace std;

class Polygon {
protected:
	int width, length;
public:
	Polygon (int a, int b) : width(a), height(b) {}
	virtual int area(void) = 0;
	void printarea() {
		cout << this->area << endl;
	}
};

class Triangle: public Polygon{
public:
	Triangle (int a, int b) : width(a), height(b) {}
	int area(void) { return width*length/2; }
};

class Rectangle: public Polygon{
public:
	Rectangle (int a, int b) : width(a), height(b) {}
	int area(void) { return width*length; }
};

int main () {
	Polygon *Tri = new Triangle(4,7);
	Polygon *Rect = new Rectangle(6,9);
	Rect->printarea();
	Tri->printarea();
	delete Tri;
	delete Rect;
	return 0;
}