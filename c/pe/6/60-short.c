#include <stdio.h>

int main(){
    short a[10];
    short *b;
    printf("%d %d %d\n", sizeof(a), sizeof(*a), sizeof(a[0]));
    printf("%d %d\n", sizeof(b), sizeof(*b));
}
