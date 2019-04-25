// printf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // int型の変数の宣言
    int target;
    int a, b, c;
    
    // 変数targetへの代入
    target = 51235;
    
    // 加減乗除は+-*/、また剰余は%で表現する.
    a = target * 10;
    b = target / 10;
    c = target % 10;

    // printf関数. ""で囲まれた文字列を端末に出力する.
    // \nは改行コードを意味する.
    // %dはカンマの後ろで指定された変数で順番に置換される.
    printf("%d %d %d\n", a, b, c);

    // main関数の正常終了
    return 0;
}
