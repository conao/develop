// printf関数、scanf関数を使うために必要
#include <stdio.h>

// exit関数、malloc関数、calloc関数を使うために必要
#include <stdlib.h>

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

/******************************
 進数変換関連の関数群
******************************/
// Dec2Hexのサブルーチン
// 1桁のインデックスに応じたHexのシンボルを返す。
// 1->'1', 9->'9', 10->'A', 15->'F'
char Dec2HexFunc(int source) {
    if (16 < source) {
	printf("Overfrow at Dec2HexFunc!! source is %d (> 16)\n", source);
        exit(1);
    }
    if (source < 10) {
	return '1' - 1 + source;
    } else {
	return 'A' - 1 + (source - 9);
    }
}

// 10進数を2進数に変換する。
// targetは配列の一番最後の要素のポインタである必要がある。
void Dec2Bin(int source, int *target) {
    int maxBinDigit;
    int digit;

    // sourceを2進数と考えた時の桁数
    maxBinDigit = sizeof(int)*8;
    for (digit = 0; digit < maxBinDigit; digit += 1, target--) {
        // sourceの末尾1ビットをビット積で切り出す。
        // そのままintの数字と考え、代入する。
	*target = source & 1;

        // sourceを右ビットシフトする(2で除算する)
	source >>= 1;
    }
}

// 10進数を8進数に変換する。
// targetは配列の一番最後の要素のポインタである必要がある。
void Dec2Oct(int source, int *target) {
    int maxBinDigit;
    int digit;

    // sourceを2進数と考えた時の桁数
    maxBinDigit = sizeof(int)*8;
    for (digit = 0; digit < maxBinDigit; digit += 3, target--) {
        // sourceの末尾3ビットをビット積で切り出す。
        // そのままintの数字と考え、代入する。
	*target = source & 7;

        // sourceを右ビットシフトする(2^3で除算する)
	source >>= 3;
    }
}

// 10進数を16進数に変換する。
// targetは配列の一番最後の要素のポインタである必要がある。
// サブルーチンとして、Dec2HexFuncに依存している。
void Dec2Hex(int source, char *target) {
    int maxBinDigit;
    int digit;

    // sourceを2進数と考えた時の桁数
    maxBinDigit = sizeof(int)*8;
    for (digit = 0; digit < maxBinDigit; digit += 4, target--) {
        // sourceの末尾4ビットをビット積で切り出す。
        // Dec2HexFuncに渡し、シンボルを代入。
	*target = Dec2HexFunc(source & 15);

        // sourceを右ビットシフトする(2^4で除算する)
	source >>= 4;
    }
}

/******************************
 配列関連の関数群
******************************/
void showIntArray(int *target, int index, int frgNewLine) {        
    while (index > 0) {
        printf("%d", *target);
        target++;
        index--;
    }
    if (frgNewLine) {
        printf("\n");
    }
}

void showCharArray(char *target, int index, int frgNewLine) {        
    while (index > 0) {
        printf("%c", *target);
        target++;
        index--;
    }
    if (frgNewLine) {
        printf("\n");
    }
}

int main() {
    int target;

    // 演算結果を代入する変数群
    int *targetBin;
    int *targetOct;
    char *targetHex;
    
    // それぞれの進数での桁数
    int binDigit;
    int octDigit;
    int hexDigit;

    // +0.9は繰り上げ処理
    binDigit = sizeof(int)*8;
    octDigit = sizeof(int)*8 / (float)3 + 0.9;
    hexDigit = sizeof(int)*8 / (float)4 + 0.9;

    // xmallocで動的にメモリ領域を確保する
    targetBin = (int *)xmalloc(sizeof(int)*binDigit);
    targetOct = (int *)xmalloc(sizeof(int)*octDigit);
    targetHex = (char *)xmalloc(sizeof(char)*hexDigit);

    // 標準入力からデータをもらう
    scanf("%d", &target);


    // 2進数に変換し、表示する
    Dec2Bin(target, &targetBin[binDigit - 1]);
    showIntArray(targetBin, binDigit, 0);
    printf(" (2)\n");

    // 8進数に変換し、表示する
    Dec2Oct(target, &targetOct[octDigit - 1]);
    showIntArray(targetOct, octDigit, 0);
    printf(" (8)\n");

    // 16進数に変換し、表示する
    Dec2Hex(target, &targetHex[hexDigit - 1]);
    showCharArray(targetHex, hexDigit, 0);
    printf(" (16)\n");

    return 0;
}
