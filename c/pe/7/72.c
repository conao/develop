#include <stdio.h>

int main() {
    int n;
    scanf("%d",&n);
    printf("%d is ",n);
    switch (n) {
    case 2:
        printf("two.\n");
        break;
    case 3:
        printf("two plus ");
    case 1:
        printf("one.\n");
        break;
    default:
        printf("otherwise.\n");
    }
    return 0;
}
