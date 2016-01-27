#include <stdio.h>

void swap1 (int *x, int *y) {
    int z;
    z = *x; *x = *y; *y = z;
}

int main() {
    int a;
    int b;
    a = 3;
    b = 4;
    swap1(&a, &b);
    printf("%d, %d\n", a, b);
    return 0;
}
