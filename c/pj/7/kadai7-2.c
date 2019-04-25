// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// sin関数、及びcos関数を使用するために必要
#include <math.h>

// main関数の宣言
main() {
    // 変数宣言
    // name[size]と宣言すると、name[0]からname[size-1]まで確保される
    int i, j;
    double a[2][2];
    double theta;
    double x[2];
    double y[2];

    // printf関数。標準入力から入力を取得する。
    // printf(フォーマット指定子, 変数)    
    printf("回転（ラジアン）");

    // scanf関数。標準入力から入力を取得する。
    // scanfには変数のアドレスを渡すため、& を語頭に付与する。
    // scanf(フォーマット指定子, 変数)
    scanf("%lf", &theta);

    // 回転行列の作成
    a[0][0] = cos(theta);  a[0][1] = -sin(theta);
    a[1][0] = sin(theta);  a[1][1] =  cos(theta);

    // 元の座標の入力
    printf("元の座標:");
    scanf("%lf %lf", &x[0], &x[1]);

    for (i=0; i<2; i++) {
        // 変数の初期化
        y[0] = 0;
        y[1] = 0;

        for (j=0; j<2; j++) {
            // 内積の計算
            y[i] += a[i][j] * x[j];
        }
    }

    // 結果の出力
    printf("変換後の座標 (%f, %f)\n", y[0], y[1]);
}


