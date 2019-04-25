#include <stdio.h>
#include <stdlib.h>

int main() {
    int i, j, m, n;
    // プログラム内で行列サイズを後から与える
    m = 2;
    n = 2;
    float **a = (float **)malloc(m * sizeof(float*));
    for (i = 0; i < m; i++) {
        a[i] = (float *)malloc(n * sizeof(float));
    }

    // 初期値のセット
    a[0][0] = 1;
    a[0][1] = 4;
    a[1][0] = 3;
    a[1][1] = 2;

    // ラベルの出力
    printf("raw value:\n");
    for (i = 0; i < 2; i++) {
        for (j = 0; j < 2; j++) {
            printf("i = %d, j = %d, a[i][j] = %.1f\n", i, j, a[i][j]);

            // 各要素を2倍する
            a[i][j] *= 2;
        }
    }

    // ラベルと行列の要素の出力
    printf("processed value:\n");
    for (i = 0; i < 2; i++) {    
        for (j = 0; j < 2; j++) {
            printf("i = %d, j = %d, a[i][j] = %.1f\n", i, j, a[i][j]);
        }
    }

    return 0;
}
