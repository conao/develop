#include <stdio.h>
// pow関数を使用するために必要
#include <math.h>

int myatoi(char target[]) {
    // 変数の宣言
    // 答えを代入する
    int result;
    // 各桁の重みを管理する
    int weight;
    // 現在参照中の桁
    int digit;

    weight = 0;
    while (target[weight] != '\0') {
        weight++;
    }
    
    // 桁数と重みのズレを修正する。例えば3桁目は10*2の重み。
    weight--;
    // resultの初期化
    result = 0;
    // 終端文字まで処理を継続する
    for (digit = 0; target[digit] != '\0'; digit++) {
        // 各桁の重みをかけて、resultに加算する
        result += pow(10, weight) * (target[digit]-'1'+1);
        weight--;
    }
    return result;
}

int main(){
    char a[]="12345";
    printf("a[]=%s, a=%d\n",a,myatoi(a));
    return(0);
}
