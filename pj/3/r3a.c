// printf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // int型の変数の宣言
    int target;
    
    // 変数targetへの代入
    target = 51235;
    
    // printf関数. ""で囲まれた文字列を端末に出力する.
    // \nは改行コードを意味する.
    // %dはカンマの後ろで指定された変数で置換される.
    printf("%d\n", target);

    // main関数の正常終了
    return 0;
}
