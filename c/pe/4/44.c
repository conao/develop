// scanf, printf関数を使うために必要
#include <stdio.h>
// sqrt関数を使うために必要
#include <math.h>

// グローバル変数の宣言
// 解がひとつだけの場合はans[0]のみを用いる
double ans[2];
// 解の実数部分(虚数解の場合)
double real;
// 解の虚数部分(虚数解の場合)
double comp;


// a,b,cの係数を受け取り、重解を求める
void calcSoleAns(double a, double b, double c) {
    ans[0] = (1/(2*a))*(-1)*b;
    return;
}

// a,b,cの係数を受け取り、複素数解を求める
void calcComplexAns(double a, double b, double c) {
    real = (1/(2*a))*(-1)*b;
    comp = (1/(2*a))*sqrt((-1)*(b*b-4*a*c));
    return;
}

// a,b,cの係数を受け取り、2つの異なる実数解を求める
void calcAns(double a, double b, double c) {
    ans[0] = (1/(2*a))*((-1)*b+sqrt(b*b-4*a*c));
    ans[1] = (1/(2*a))*((-1)*b-sqrt(b*b-4*a*c));
    return;
}

// a=0の場合は線形方程式になるので、ひとつの解だけを求める
void calcLinearAns(double b, double c) {
    ans[0] = c/b;
    return;
}

// a,b,cの係数を受け取り、判別式の値を求める
double D(double a, double b,double c){
    double d;
    d = b*b - 4.0*a*c;
    return d; 
}

// int型を返すmain関数の宣言
int main() {
    // double型変数の宣言
    double a, b, c, d;
    
    // ラベルの表示
    // 順次a,b,cの係数を標準入力から受け取る
    printf("calc x.\nax^2+bx+c=0\n");
    printf("Input a... ");
    scanf("%lf", &a);

    printf("Input b... ");
    scanf("%lf", &b);

    printf("Input c... ");
    scanf("%lf", &c);

    // 答えのラベルの表示
    printf("x = ");
    
    if (a == 0) {
        if (b == 0) {
            // a=0, b=0の場合、xは不定となる
            printf("Undefined...\n");
        } else {
            // a=0の時、線形方程式となる
            calcLinearAns(b, c);
            printf("%lf\n", ans[0]);
        }
    } else {
        // 判別式の値をdに代入する
        d = D(a,b,c);
        if(d > 0) {
            // 判別式の値が正なので、2つの異なる実数解を求める
            calcAns(a, b, c);
            printf("%lf, %lf\n", ans[0], ans[1]);
        } else if (d < 0) {
            // 判別式の値が不なので、2つの虚数解を求める
            calcComplexAns(a, b, c);
            printf("%lf+%lfi, %lf-%lfi\n", real, comp, real, comp);
        } else {
            // 判別式の値が0なので、線形方程式を解いて1つの解を得る
            calcSoleAns(a, b, c);
            printf("%lf\n", ans[0]);
        }
    }
    
    // main関数の正常終了
    return 0; 
}
