#include<stdio.h>

char mytoupper(char c){
//TODO a~Zの書き分け
    c -= 'a' - 'A';
    return c;
}

int main(){
    char c;

    printf("Input a string\n");
    while ((c = getchar()) != '\n') {
        if ('a' <= c && c <= 'z') {
            // aからzの文字の時だけmytoupperを呼ぶ
            printf("%c", mytoupper(c));            
        } else {
            // aからzの文字以外の時はそのまま表示する
            printf("%c", c);
        }
    }
    printf("\n");
    return 0;
}
