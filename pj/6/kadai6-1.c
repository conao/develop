// printf関数、及びscanf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
main() {
    // 変数の宣言
    float pi = 3.14159;
    float r;
    float s;
    float v;

    // printf関数。フォーマット指定子に従って標準出力に出力する。
    // printf(フォーマット指定子, 変数)       
    printf("半径を入力してください : ");
    
    // scanf関数。標準入力から入力を取得する。
    // scanfには変数のアドレスを渡すため、& を語頭に付与する。
    // scanf(フォーマット指定子, 変数)    
    scanf("%f", &r);

    // 表面積の公式
    s = 4 * pi * (r*r);
    
    printf("表面積は %f です.\n", s);

    // 演算結果を実数で得るためにキャストしている
    v = ((float)4/3) * pi * (r*r*r);
    printf("体積は %f です.\n", v);
}
