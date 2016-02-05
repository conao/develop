#include <stdio.h>

int main() {
    int i;
    char *a[] = {"Carrot","Onion","Potato"};
    char **p = a;
    for(i=0; i<3; i++) {
        printf("%c\n", *(*(p+i)+1));
    }
    return 0;
}
