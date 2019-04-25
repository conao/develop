// printf関数を使うために必要
#include <stdio.h>

// pow関数を使うために必要
#include <math.h>

// main関数の宣言
int main() {
    int int_max;
    int a;
    int b;

    // int型の最大値を求める。
    // sizeof関数でBiteが求められるので、それに8をかけることでbitを求める。
    // 最上位ビットは符号ビットなので、公式より2^((intのbit数)-1)-1が最大値
    int_max = pow(2, sizeof(int)*8 - 1) - 1;

    // (intの最大値)/2より少なくならないように適宜減算する。
    a = int_max - 100;
    b = int_max - 200;

    // 各変数の中身を表示しつつ、オーバーフローを発生させる。
    printf("int_max = %d\n", int_max);
    printf("%d + %d = %d\n", a, b, a+b);
    return 0;
}
