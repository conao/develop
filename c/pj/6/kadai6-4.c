// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// マクロ宣言。マクロで使用する変数には計算順序を維持するために
// カッコをつけることに注意する。

// 三項演算子は 条件文?真の時の実行文:偽の時の実行文 という書式

// 大きい方を返すマクロ
#define MIN(a, b) ((a) < (b) ? (a) : (b))

// 小さい方を返すマクロ
#define MAX(a, b) ((a) > (b) ? (a) : (b))

// 2乗を返すマクロ
#define POW(a) (a)*(a)


// int型を返すmain関数の宣言
int main() {
    // 変数の宣言
    // 配列の宣言は name[size] で行う。添字は0〜(size-1)まで占有している。    
    int i, j;
    int score[100];
    int sum, max, min;
    float ave, var;
    float tmpsum;

    // iの初期化。一番初めのデータはscore[0]に格納される
    i = 0;

    // scanf関数。標準入力から入力を取得する。
    // scanfには変数のアドレスを渡すため、& を語頭に付与する。
    // scanf(フォーマット指定子, 変数)    
    scanf("%d", &score[i]);

    // 一番初めの値を暫定的に、最大値であり、最小値であり、合計だとする。
    max = score[i];
    min = score[i];
    sum = score[i];

    // 無限ループ。break文によって抜け出す。
    while(1){
        // iのインクリメント
        i++;

        // iのインクリメントにより、score[1], score[2],,,に格納される
        scanf("%d", &score[i]);

        if (score[i] < 0) {
            // 負の値を受けとったときbreak文を実行する。
            break;
        }

        // 前述のマクロを使って、maxとminを更新していく
        max = MAX(max, score[i]);
        min = MIN(min, score[i]);

        // sumの更新。sum = sum + score[i]の省略形
        sum += score[i];
    }
    
    // 平均値を求める。floatで欲しいため、演算項のどちらかをfloatにキャストする。
    // 書式は (型名)変数名 でキャスト出来る
    ave = (float)sum / (i);
    
    // tmpsumの初期化。
    tmpsum = 0;
    for (j = 0; j < i; j++) {
        // 前述のPOWマクロを使って、平均とのずれの2乗を合計する。
        tmpsum += POW(score[j] - ave);
    }
    
    // 分散を求める。平均とのずれの2乗の合計の平均が分散である。
    var = tmpsum / i;

    // printf関数。フォーマット指定子に従って標準出力に出力する
    // printf(フォーマット指定子, 変数)     
    // 平均点と分散の出力が小数点以下４桁だったため、%.4fというフォーマットを指定した。
    printf("人数 : %d\n", i);
    printf("最高点 : %d\n", max);
    printf("最低点 : %d\n", min);
    printf("平均点 : %.4f\n", ave);
    printf("分散 : %.4f\n", var);
    return 0;
}
