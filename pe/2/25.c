// printf関数、scanf関数を使うために必要
#include <stdio.h>

// exit関数を使うために必要
#include <stdlib.h>

int main() {
    // long long int型の変数を宣言する
    long long int target;

    // 入力された乗数を格納する変数を宣言する
    int powNum;


    // ビット操作される元の数を代入する
    target = 1;

    // 標準入力から乗数を受け取る
    scanf("%d", &powNum);

    // 入力値が問題分の指定に沿うかどうか検査する
    if (1 <= powNum && powNum <= 32) {
	// 2のべき乗の場合、ビット操作で計算できるので、それを利用する。
	printf("2^%d = %lld\n", powNum, target << powNum);

    } else {
	// 検査に不合格の場合、エラーメッセージと共に異常終了する
	printf("Input data must be in the range from 1 to 32.\n");
	exit(1);
    }
    
    // Main関数の正常終了
    return 0;
}
