#include <stdio.h>

// 標準入力からの入力を受け取る
// argcには引数の数、*argv[]は文字列の配列に対するポインタとなる
int main(int argc, char *argv[]) {
    int i;
    int j;
    int count = 0;
    char target;

    // 標準入力から入力を受け取る
    scanf("%c", &target);

    // argv[0]には実行ファイル名が入っているので、
    // argv[1]からargv[argc-1]まで走査する
    for (i = 1; i < argc; i++) {

        // 1文字目から走査する（初期化）
        j = 0;

        // 終端文字までを走査する
        while (argv[i][j] != '\0') {
            if (argv[i][j] == target) {
                // targetと同じ文字が現れたら加算する
                count++;
            }
            // jのインクリメント(次の文字)
            j++;
        }
    }

    // ラベルと変数の内容の出力
    printf("The number of %c is %d.\n", target, count);
    return 0;
}
