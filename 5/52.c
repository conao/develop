#include<stdio.h>

int main(){
    int wnum = 0;
    int frgStart = 0;
    int frgBlank = 0;
    char c;

    printf("Input a string\n");
    while((c = getchar()) != '\n'){
        // 空白を検知したらルーチンに入る
        if (c == ' ') {
            // 文字列が始まっている時のみ単語数増加の可能性がある
            if (frgStart) {
                // 前の文字が空白でない時のみ、単語数を増加する
                if (!frgBlank) {
                    wnum++;
                }
            }
            // 空白を検知したので、フラグを立てる
            frgBlank = 1;
        } else {
            // 空白意外なので、文字列が開始したと判断する
            frgStart = 1;
            frgBlank = 0;
        }
    }
    printf("#words: %d\n", ++wnum);
    return 0;
}
