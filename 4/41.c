// printf関数を使うために必要
#include <stdio.h>
// 簡単に配列の大きさを変えるための方法
// 数字の部分を変更することで様々な場所が変更される
#define ARRAY_MAX 10

// double型を返すaveArrayの開始
// int型配列と配列のサイズを受け取り、配列の平均を返す
double aveArray (int target[], int index) {
    // 変数の宣言
    int i;
    int tmp;

    // tmpの初期化
    tmp = 0;
    // 配列の最初から最後までを走査する
    for(i = 0; i < index; i++) {
        // ひとまずtmpにすべての要素の合計を入れる
        tmp += target[i];
    }

    // 要素数で割って平均を求める
    return (double)tmp / index;
}

int main () {
    // 変数の宣言
    int i;
    // 配列のサイズをマクロで指定している
    int a[ARRAY_MAX];

    // 配列の初期化
    for(i = 0; i < ARRAY_MAX; i++) {
        // インデックスをそのまま入れたのでは味気けないので
        // 適当に50を加算したものを代入する
        a[i] = 50 + i;
    }

    // aveArrayの返り値を直接出力する
    printf("%lf\n", aveArray(a, ARRAY_MAX));
    return 0;
}








