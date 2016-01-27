#include <stdio.h>

int main(){
    char a[10];
    char *b;
    printf("%d %d %d\n", sizeof(a), sizeof(*a), sizeof(a[0]));
    printf("%d %d\n", sizeof(b), sizeof(*b));
}
