#include <stdio.h>

int main() {
    int SIZE = 4;
    int i, j, x, y;
    for (i=0; i<SIZE*SIZE; i++) {
        int x, y;
            x = (int)(i-0.5)/SIZE);
            y = (j+(i*SIZE)) % SIZE;
            printf(" %d(%d,%d)",j+(i*SIZE),x,y);
        printf("\n");
    }
    
    return 0;
}
