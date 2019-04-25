// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// exit関数を使用するために必要
#include <stdlib.h>

// 行列のサイズ宣言。修正の際は、この定数と、square変数の初期化文を修正する
#define SIZE 4

void checkMagic(int target, int sum) {
    if (target != sum) {
        printf("魔法陣ではありません\n");
        exit(1);
    }
}

// int型を返すmain関数の宣言
int main() {
    // 変数宣言
    // name[size]と宣言すると、name[0]からname[size-1]まで確保される
    int square[SIZE][SIZE] = {
        {16,  3,  2, 13},
        { 5, 10, 11,  8},
        { 9,  6,  7, 12},
        { 4, 15, 14,  1}
    };
    int i, j;
    int sum, tmp;
    int symbol[SIZE*SIZE];

    // 変数の初期化。暫定的に1行目を総和とする
    sum = 0;
    for (i=0; i<SIZE; i++) {
        sum += square[i][0];
    }

    // 斜めのチェック。
    // 左上から右下への斜め
    tmp = 0;
    for (j=0; j<SIZE; j++) {
        tmp += square[j][j];
    }
    // 斜めの総和が暫定値と合致しなかった場合、魔法陣ではない。
    checkMagic(tmp, sum);

    // 右上から左下への斜め
    tmp = 0;
    for (j=0; j<SIZE; j++) {
        tmp += square[j][SIZE-1-j];
    }
    // 斜めの総和が暫定値と合致しなかった場合、魔法陣ではない。
    checkMagic(tmp, sum);
    

    // 横の総和のチェック
    for (i=0; i<SIZE; i++) {
        tmp = 0;
        for (j=0; j<SIZE; j++) {
            tmp += square[i][j];
        }
        // 横の総和が暫定値と合致しなかった場合、魔法陣ではない。
        checkMagic(tmp, sum);
    }

    // 縦の総和のチェック
    for (i=0; i<SIZE; i++) {
        tmp = 0;
        for (j=0; j<SIZE; j++) {
            tmp += square[j][i];
        }
        // 縦の総和が暫定値と合致しなかった場合、魔法陣ではない。
        checkMagic(tmp, sum);
    }

    // 各数字（シンボル）が１つずつ使われているか調べる。
    // 使用状況を0で初期化する。
    for (i=0; i<SIZE*SIZE; i++) {
        symbol[i] = 0;
    }
    
    // 各セルを周り、出会った数字に対応する変数を1に置き換える。
    // この時、すでに0以外(使用済み)であった場合、魔法陣ではない。
    for (i=0; i<SIZE; i++) {
        for (j=0; j<SIZE; j++) {
            if (symbol[square[i][j]-1] == 0) {
                symbol[square[i][j]-1] = 1;
            } else {
                printf("魔法陣ではありません\n");
                return -1;
            }
        }
    }
    
    // すべてのチェックが済み、それに合格したならば、
    // それはまさしく魔法陣である。
    printf("魔法陣です\n");
    return 0;
}
