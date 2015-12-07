#include<stdio.h>

main() {
    int a = 1;
    int b = 2, c;
    
    c = a > b || b + 1 != 1 & 5 == 5;
    printf("c=%d\n",c);
}
