// printf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // float型の変数の宣言
    float target, a, b, c, d;

    // 変数targetへの代入
    target = 51235;
    
    // 加減乗除は+-*/、また剰余は%で表現する.
    a = target + 7.0;
    b = target - 7.0;
    c = target * 7.0;
    d = target / 7.0;

    // printf関数. ""で囲まれた文字列を端末に出力する.
    // \nは改行コードを意味する.
    // %dはカンマの後ろで指定された変数で順番に置換される.
    // %dは整数型の指定であり、%fで浮動小数点型を指定する.
    // %<a>.<b>fと指定することで少数点以上a桁、小数点以下b桁の指定となる.
    // 桁溢れの場合、小数点以下b+1桁目が四捨五入され、丸められる.
    printf("%.2f %.2f %.2f %.2f\n", a, b, c, d);

    // main関数の正常終了
    return 0;
}
