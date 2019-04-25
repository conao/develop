// printf関数を使用するために必要
#include <stdio.h>

// int型を返す main関数の宣言
int main() {
    // 変数の宣言
    int i;
    
    // for pattern
    // for (初期化文; 継続評価文; 再初期化文) {繰り返し処理}
    // 最初に 20 を i に代入し、2 以上の間、2 づつ減算しつつ表示する
    for (i = 20; i >= 2; i -= 2) {
        printf("%d, ", i);
    }
    printf("\n");
    
    // while pattern
    // 初期化文; while (継続評価文) {繰り返し処理; 再初期化文;}
    // 最初に 20 を i に代入し、2 以上の間、2 づつ減算しつつ表示する
    i = 20;
    while (i >= 2) {
        printf("%d, ", i);
        i -= 2;
    }
    printf("\n");
    
    // do-while pattern
    // 初期化文; do {繰り返し文; 再初期化文;} while (継続評価文);
    // 最初に 20 を i に代入し、2 以上の間、2 づつ減算しつつ表示する
    i = 20;
    do {
        printf("%d, ", i);
        i -= 2;
    } while (i >= 2);
    printf("\n");

    // main関数の正常終了
    return 0;
}
