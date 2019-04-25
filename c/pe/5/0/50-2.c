#include<stdio.h>

int main(){
    int wnum = 0;
    char c;

    printf("Input a string\n");
    while((c = getchar()) != '\n'){
        if (c == ' ') {
            wnum++;
        }
    }
    printf("#words: %d\n", ++wnum);
    return 0;
}
