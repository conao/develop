#include <stdio.h>

int main(){
    int a[10];
    int *b;
    printf("%d %d %d\n", sizeof(a), sizeof(*a), sizeof(a[0]));
    printf("%d %d\n", sizeof(b), sizeof(*b));
}
