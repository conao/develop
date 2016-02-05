#include <stdio.h>

// 標準入力からの入力を受け取る
// argcには引数の数、*argv[]は文字列の配列に対するポインタとなる
int main(int argc, char *argv[]) {
    int i = 0;

    // 引数の数を出力する
    printf("Number of arguments: %d\n", argc);

    // argvの終端はNULLであることが保証されているので、
    // それを利用してそこまで走査する
    while(argv[i] != NULL) {

        // ラベルと情報の出力
        printf("argv[%d]: %s\n", i, argv[i]);

        // iのインクリメント
        i++;
    }
    return 0;
}
