#include <stdio.h>

int main(){
    long a[10];
    long *b;
    printf("%d %d %d\n", sizeof(a), sizeof(*a), sizeof(a[0]));
    printf("%d %d\n", sizeof(b), sizeof(*b));
}
