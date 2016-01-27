// scanf, printf関数を使うために必要
#include <stdio.h>

// pow関数を使うために必要
#include <math.h>

// exit関数を使うために必要
#include <stdlib.h>


// main関数の開始
int main() {

    // 変数の宣言
    int i, x;
    int count = 0;


    // 標準入力から整数でキャストして取得
    scanf("%d", &x);

    // 取得データの検査。8bitより(2^8)-1以上のデータはオーバーフローする
    if (x >= pow(2, 8)) {
        printf("Input data must be in the range from 1 to (2^8)-1.\n");
        exit(1);
    }

    // ビット演算で一桁ずつ求める
    for (i=0; i<8; i++) {

        // 最下位ビットが1の時 x&1 は1を返す(True)
        if (x & 1) {
            // countのインクリメント
            count++;
        }

        // 右ビットシフト(2で除算, 余り無視)
        x >>= 1;
    }

    // countの出力
    printf("%d\n", count);

    // main関数の正常終了
    return 0;
}
