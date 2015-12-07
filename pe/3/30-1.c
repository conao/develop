#include <stdio.h>

int main() {
    int i, x;
    int b[8];

    scanf("%d", &x);

    for (i=0; i<8; i++) {
        b[i] = x & 1;
        x = x >> 1;
    }
    
    for (i=0; i<8; i++) {
        printf("%d", b[7-i]);
    }
    
    printf("\n");
    return 0;
}
