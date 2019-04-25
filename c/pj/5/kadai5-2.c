// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // 変数の宣言
    int charCount;

    // scanf関数。標準入力から入力を取得する。
    // scanfには変数のアドレスを渡すため、& を語頭に付与する。
    // scanf(フォーマット指定子, 変数)
    scanf("%d", &charCount);

    for( ; charCount > 0; charCount--) {
        printf("*");
    }
    printf("\n");

    // main関数の正常終了
    return 0;
}
