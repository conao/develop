#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // 変数の宣言
    int i;
    int target;

    // scanf関数。標準入力から入力を取得する。
    // scanfには変数のアドレスを渡すため、& を語頭に付与する。
    // scanf(フォーマット指定子, 変数)
    scanf("%d", &target);

    // 素因数 1 つめ
    // target以下の整数で割り切れたらすぐにWhileを抜ける。
    // break文を実行した瞬間にWhile文を抜ける
    for(i = 2; i <= target; i++) {
        if(target % i == 0) {
            printf("%d", i);
            target /= i;
            break;
        }
    }

    // 2こめ以降の素因数
    // targetが1になるまでtargetを上書きしつつWhile文を回る。
    // break文が実行されると、forを抜ける。
    // 全体の繰り返しはtargetが1になるまでの指定となっている。
    while(target != 1) {
        for(i = 2; i <= target; i++) {
            if(target % i == 0) {
                printf("*%d", i);
                target /= i;
                break;
            }
        }
    }
    printf("\n");

    // main関数の正常終了
    return 0;
}
