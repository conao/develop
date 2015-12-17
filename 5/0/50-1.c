#include<stdio.h>

char mytoupper(char c){
    c -= 'a' - 'A';
    return c;
}

int main(){
    char c;

    printf("Input a string\n");
    while((c = getchar()) != '\n')
        printf("%c", mytoupper(c));
    printf("\n");
    return 0;
}
