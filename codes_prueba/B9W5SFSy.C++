#include <stdio.h>
#include <math.h>


struct T {
    int x, y;
    
    T(int x, int y) : x(x), y(y) {}
    
    bool cross(T *b) {
        return (fmin(y, b->y) >= fmax(x, b->x));
    }
};

bool cross(T *a, T *b) {
    return (fmin(a->y, b->y) >= fmax(a->x, b->x));
}

int main() {
    T *q = new T(2, 3), *w = new T(3, 7);
    
    cross(q, w);
    
    printf("%d\n", q->cross(w));
    
    return 0;
}