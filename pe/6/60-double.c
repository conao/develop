#include <stdio.h>

int main(){
    double a[10];
    double *b;
    printf("%d %d %d\n", sizeof(a), sizeof(*a), sizeof(a[0]));
    printf("%d %d\n", sizeof(b), sizeof(*b));
}
