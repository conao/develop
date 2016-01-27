// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // 変数の宣言
    // 配列の宣言は name[size] で行う。添字は0〜(size-1)まで占有している。
    int i;
    int a[21];

    // 配列の初期化
    a[0] = 1;
    a[1] = 1;
    for (i = 2; i < 21; i++) {
        a[i] = a[i-1] + a[i-2];
    }

    // 結果の表示
    for (i = 1; i < 21; i++) {
        // printf関数。フォーマット指定子に従って標準出力に出力する
        // printf(フォーマット指定子, 変数)               
        printf("a[%2d]=%6d,    a[%2d]/a[%2d]=%f\n", i, a[i], i, i-1, (float)a[i]/a[i-1]);
    }

    // main関数の正常終了
    return 0;
}
