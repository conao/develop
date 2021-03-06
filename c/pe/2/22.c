// printf関数を使うために必要
#include <stdio.h>

// malloc関数、calloc関数を使うために必要
#include <stdlib.h>

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

// Hex to Decimalの略。16進数から10進数に変換する。少数にも対応している。
// 進数変換の他の関数に引数を揃えている。
// multiは初期状態で16^(整数桁-1)である必要がある。
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

// Change Integer to Octalの略。10進数から2進数に変換する。整数部のみ対応
// CIntOctが再帰するたびに*pが後ろに行く（桁あがり）
// 初期状態で*pは配列の一番右のポインタである必要がある。
void CIntOct(int *p, int target) {
    if (target == 1) {
        *p = 1;
    } else {
        *p = target % 8;  /* 1~7までの整数 */
        CIntOct(--p, (int)(target/8));  /* 小数部切り捨てで再帰 */
    }
}


/******************************
 配列に対する一般的な関数群
******************************/
// Initial Arrayの略。配列を0で初期化する
void initArray(int *target, int index) {
    if (index == 0) {
        return;
    } else {
        *target = 0;
        initArray(++target, --index);
    }
}

// Display Arrayの略。配列の中身を表示する。最後に改行を出力する。
void dispArray(int *target, int index, int frgBreak) {
    if (index == 0)  {
	if (frgBreak) {
	    printf("\n");
	}
        return;
    } else {
        printf("%d", *target);
        dispArray(++target, --index, 0);
    }
}

int main() {
    char target[] = "235";
    int digit = 3;
    int decimalTarget;
    int OctTarget[10];

    // Hex2Decにデータを投げて直接printfで出力する。
    decimalTarget = (int)Hex2Dec(target, pow(16, digit-1), digit);

    printf("%s(16) = %d(10)\n", target, decimalTarget);


    // CIntOctでOctTargetに8進数のデータを詰め込む
    initArray(OctTarget, 10);
    CIntOct(&OctTarget[9], decimalTarget);

    // ラベルの出力
    printf("%s(16) = ", target);

    // OctTargetの中身を表示する
    dispArray(OctTarget, 10, 0);

    // 終了ラベルの出力
    printf("(8)\n");
    return 0;
}
