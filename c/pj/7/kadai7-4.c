// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // 変数宣言
    // name[size]と宣言すると、name[0]からname[size-1]まで確保される
    int bomb[5][5] = {
        {1, 0, 0, 1, 1},
        {0, 0, 0, 1, 0},
        {0, 1, 0, 0, 1},
        {0, 0, 0, 0, 0},
        {1, 0, 0, 1, 0}
    };
    int sweep[5][5];
    int i, j;
    int xShift, yShift;
    int x, y;
    int bombCount;

    // 2次元配列sweepを作成します
    // 基準のセルを動かします。範囲はi,jともに0~4です
    for (i=0; i<5; i++) {
        for (j=0; j<5; j++) {
            // 基準のセルの周囲にある、爆弾の数を数える変数の初期化
            bombCount = 0;

            // 基準のセルから縦横+-1マス動かします。
            for (xShift = -1; xShift <= 1; xShift++) {
                for (yShift = -1; yShift <= 1; yShift++) {
                    
                    // x,yシフトがともに0になった場合は
                    // 自分自身を指すのでcontinue文でスルーします。
                    if (xShift == 0 && yShift == 0) {
                        continue;
                    }
                    
                    // 今後の条件文等で頻繁に使用するため、変数を置き直します。
                    // x,yが調べるセルの座標になっています。
                    x = i + xShift;
                    y = j + yShift;
                    
                    // x,yがbombの範囲を超えていないかチェックします。
                    if ((0 <= x && x < 5) && (0 <= y && y < 5)) {

                        // bomb変数を見て、爆弾だとbombCountをインクリメントします。
                        if (bomb[x][y] == 1) {
                            bombCount++;
                        }
                    }
                }
            }
            // bombCountをsweepに移します。
            sweep[i][j] = bombCount;
        }
    }
    
    // 爆弾があった場所を-1で上書きします。
    for (i=0; i<5; i++) {
        for (j=0; j<5; j++) {
            if (bomb[i][j] == 1) {
                sweep[i][j] = -1;
            }
        }
    }
    
    // 2次元配列sweepを表示します
    for (i=0; i<5; i++) {
        for (j=0; j<5; j++) {

            // -1でなかった場合、そのまま表示し、
            // -1の場合 X を表示します。
            if (sweep[i][j] != -1) {
                printf("%d", sweep[i][j]);
            } else {
                printf("X");
            }
        }
        printf("\n");
    }
    
    return 0;
}
