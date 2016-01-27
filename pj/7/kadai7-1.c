// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // 変数の宣言
    // name[size]と宣言すると、name[0]からname[size-1]まで確保される
    int a[4][4] = {
         { 1,  2,  3,  4},  
         { 5,  6,  7,  8},  
         { 9, 10, 11, 12}, 
         {13, 14, 15, 16}
    };
    int i, j;

    // printf関数。標準入力から入力を取得する。
    // printf(フォーマット指定子, 変数)    
    printf("行列A\n");
    for (i=0; i<4; i++) {
        for (j=0; j<4; j++) {

            // %3dを指定することで、必ず3桁分のスペースを確保し出力する。
            printf("%3d", a[i][j]);
        }
        // 行末に改行を出力する
        printf("\n");
    }
    
    printf("行列Aの転置\n");
    for (i=0; i<4; i++) {
        for (j=0; j<4; j++) {
            printf("%3d", a[j][i]);
        }
        // 行末に改行を出力する
        printf("\n");
    }

    // main関数の正常終了
    return 0;
}
