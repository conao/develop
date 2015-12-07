// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // 変数の宣言
    int i;
    int charCount;

    // scanf関数。標準入力から入力を取得する。
    // scanfには変数のアドレスを渡すため、& を語頭に付与する。
    // scanf(フォーマット指定子, 変数)
    scanf("%d", &charCount);
    
    // * を表示する度、0 になるまでcharCountをデクリメントする。
    // for (初期化文; 継続評価文; 再初期化文) {繰り返し処理}
    for( ; charCount > 0; charCount--) {

        // 2回目のfor文。charCountの数だけ * を表示する
        for(i = 0; i < charCount; i++) {
            printf("*");
        }
        printf("\n");
    }

    // main関数の正常終了
    return 0;
}
