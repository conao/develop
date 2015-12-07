// printf関数を使うために必要
#include <stdio.h>

// double型を返すcalcBMIの開始
// double型のweightとdouble型のheightを受け取り、BMIを返す
double calcBMI (double weight, double height) {
    return weight / height / height;
}

// double型を返すcalcStandardWeightの開始
// double型のheightを受け取り、標準体重を返す
double calcStandardWeight (double height) {
    return height * height * 22;
}

//int型を返すmain関数の始まり
int main () {
    // 変数の宣言
    double weight;
    double height;

    // ラベルの表示
    printf("体重を入力して下さい(小数可[kg])...\n");
    // 標準入力から入力を受け取る
    // もし整数で入力されてもscanfがよしなにしてくれて、double型に変換される
    scanf("%lf", &weight);
    printf("身長を入力して下さい(小数可[m])...\n");
    scanf("%lf", &height);

    // ラベルの表示をしつつ、サブルーチンの出力を直接表示する
    printf("あなたのBMIは...     %lf\n", calcBMI(weight, height));
    printf("あなたの標準体重は... %lf\n", calcStandardWeight(height));
    return 0;
}
