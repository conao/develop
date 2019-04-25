// printf関数を使うために必要
#include <stdio.h>

// pow関数を使うために必要
#include <math.h>

// main関数の宣言
int main() {
    int int_min;
    int a;
    int b;

    // int型の最小値を求める。
    // sizeof関数でBiteが求められるので、それに8をかけることでbitを求める。
    // 最上位ビットは符号ビットなので、公式より(-1)*2^((intのbit数)-1)が最小値
    int_min = (-1)*pow(2, sizeof(int)*8-1);

    // (intの最小値)/2より少なくならないように適宜加算する。
    a = int_min + 100;
    b = int_min + 200;

    // 各変数の中身を表示しつつ、オーバーフローを発生させる。
    printf("int_min = %d\n", int_min);
    printf("%d + (%d) = %d\n", a, b, a+b);
    return 0;
}
