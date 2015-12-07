// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // 変数の宣言
    // 配列の宣言は name[size] で行う。添字は0〜(size-1)まで占有している。    
    int i;
    int a[11];
    float tmp;

    // 入力
    for (i = 0; i <= 10; i++) {
        // scanf関数。標準入力から入力を取得する。
        // scanfには変数のアドレスを渡すため、& を語頭に付与する。
        // scanf(フォーマット指定子, 変数)            
        scanf("%d", &a[i]);
    }

    // 計算
    tmp = a[10];
    for (i = 10; i >= 1; i--) {
        tmp = a[i-1] + (1 / tmp);
    }

    // printf関数。フォーマット指定子に従って標準出力に出力する。
    // printf(フォーマット指定子, 変数)       
    printf("%f\n", tmp);

    // main関数の正常終了
    return 0;
}
