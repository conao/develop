// printf関数、scanf関数を使うために必要
#include <stdio.h>

// exit関数、malloc関数、calloc関数を使うために必要
#include <stdlib.h>

// strLen関数を使うために必要
#include <string.h>

// pow関数を使うために必要
#include <math.h>


/******************************
 動的メモリ確保関連の関数群
******************************/

// malloc関数の修正関数
// メモリ確保に失敗した場合、エラーメッセージと共に異常終了する
void *xmalloc(size_t size) {
    void *p;
    p = malloc(size);

    // mallocはメモリ確保に失敗した場合、Nullを返す
    if (!p) {
        printf("faiied malloc");
        exit(1);
    }
    return p;
}

// calloc関数の修正関数
// メモリ確保に失敗した場合、エラーメッセージと共に異常終了する
void *xcalloc(size_t num, size_t size) {
    void *p;
    p = calloc(num, size);

    // callocはメモリ確保に失敗した場合、Nullを返す
    if (!p) {
        printf("failed calloc");
        exit(1);
    }
    return p;
}


/******************************
 進数変換関連の関数群
******************************/

// Hex2Decの本体。A~Fまでがintに変換されたtargetを受け取って、10進数に変換する
// Hex2DecMainが再帰するたびにmultiが次々16で割られていく。それをindex回続ける。
// multiは初期状態で16^(整数桁-1)である必要がある。
// 最上位桁から最下位桁までその桁の重みを掛けて、加算する。
float Hex2DecMain(int *target, float multi, int index) {
    if (index == 1) {
        return *target * multi;
    } else {
        return (*target * multi) + Hex2DecMain(++target, multi/16, --index);
    }
}

// Change Hex symbolの略。A~Fまでをintに変換し、配列に詰め込む。
void CHexSymbol(char *symbol, int *target) {
    if (*symbol) {
	if ('1' <= *symbol && *symbol <= '9') {
	    // *symbolが数字の場合
	    *target = *symbol - '1' + 1;
	} else if ('A' <= *symbol && *symbol <= 'F') {
	    // *symbolがA~Fの場合
	    *target = *symbol - (int)'A' + 10;
	} else {
	    // *symbolがその他の場合。データ異常のため以上終了する。
	    printf("Error at CHexSymbol!! %c is not allowed!!", *symbol);
	    exit(1);
	}
	CHexSymbol(++symbol, ++target);
    }
}

// indexは整数部の桁数
float Hex2Dec(char *symbol, float multi, int index) {
    int *target;
    float result;
    
    // targetを指定された桁数分確保する。
    // 確保されたメモリ領域は0で初期化される。
    target = (int*)xcalloc(index, sizeof(int));
    
    CHexSymbol(symbol, target);
    result = Hex2DecMain(target, multi, index);

    // targetの開放
    free(target);
    return result;
}

// Octal to Decimalの略。16進数から10進数に変換する。少数にも対応している。
// Oct2Decが再帰するたびにmultiが次々8で割られていく。それをindex回続ける。
// multiは初期状態で8^(整数桁-1)である必要がある。
// 最上位桁から最下位桁までその桁の重みを掛けて、加算する。
// indexは整数部の桁数
float Oct2Dec(int *target, float multi, int index) {
    if (index == 1) {
        return *target * multi;
    } else {
        return (*target * multi) + Oct2Dec(++target, multi/8, --index);
    }
}

int main() {
    char HexTarget[] = "CF";
    int digit;
    int OctTarget[] = {3,6,2};

    /******************************
     1. 16進数 CFを10進数で表わせ
    ******************************/
    // HexTargetの桁数を調べる
    digit = strlen(HexTarget);

    // Hex2Decにデータを投げて直接printfで出力する。
    printf("CF(16) = %d\n", (int)Hex2Dec(HexTarget, pow(16, digit-1), digit));


    /******************************
     2. 8進数 362を10進数で表わせ
    ******************************/
    // OctTargetの整数部の桁数
    digit = 3;

    // Oct2Decにデータを投げて直接printfで出力する。
    printf("362(8) = %d\n", (int)Oct2Dec(OctTarget, pow(8, digit-1), digit));
    return 0;
}
