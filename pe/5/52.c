#include<stdio.h>

int main(){
    int wnum = 0;
    int frgChar;
    char c;

    printf("Input a string\n");

    // すべての文字列は空白で始まっていると考える
    frgChar = 0;
    while((c = getchar()) != '\n'){
        // 文字を検知したらルーチンに入る
        if (c > ' ') {
            if (!frgChar) {
                frgChar = 1;
                wnum++;
            }
        } else {
            // 空白の場合フラグを倒す
            frgChar = 0;
        }
        //printf("%d,", c);
    }
    printf("#words: %d\n", wnum);
    return 0;
}
