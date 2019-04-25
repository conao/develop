#include <stdio.h>

int main() {
    int a = 0;
    int b = 0;

    if (a == 0 || b++) {
        printf("True\n");
    } else {
        printf("False\n");
    }
    printf("b = %d\n", b);
    
    return 0;
}
