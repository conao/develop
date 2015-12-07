// printf関数を使用するために必要
#include <stdio.h>

// int型を返すmain関数の宣言
int main() {
    // int型の変数の宣言
    int y = 2020;
    int m = 2;
    int d = 1;
    int w;

    // printf関数. ""で囲まれた文字列を端末に出力する.
    // \nは改行コードを意味する.
    // y, mは上書きするので、処理を開始する前に出力する.
    printf("%d/%d/%d is ", y, m, d);

    // y, mの上書き.変更は次のように行われる
    // m=1 -> m=13, y--
    // m=2 -> m=14, y--
    if (m == 1 || m == 2) {
        y--;
        m += 12;
    }
    
    // ツェラーの公式
    w = y + (y/4) - (y/100) + (y/400) + (((13*m)+8)/5) + d;
    w %= 7;

    // wの値によって条件分岐する.
    switch (w) {
	case 0:
		printf("Sunday");
		break;
	case 1:
		printf("Monday");
		break;
	case 2:
		printf("Tuesday");
		break;
    case 3:
		printf("Wednesday");
		break;
    case 4:
		printf("Thursday");
		break;
    case 5:
		printf("Friday");
		break;
    case 6:
		printf("Saturday");
		break;
    }

    // 最後にピリオドと改行を出力する.
    printf(".\n");

    // main関数の正常終了
    return 0;
}
