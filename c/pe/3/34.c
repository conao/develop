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

char Dec2HexFunc(int source) {
    if (16 < source) {
	printf("Overfrow at Dec2HexFunc!! source is %d (> 16)\n", source);
    }
    if (source < 10) {
	return '1' - 1 + source;
    } else {
	return 'A' - 1 + source;
    }
}

void Dec2Bin(int source, int *target) {
    int maxDigit;
    int digit;

    maxDigit = sizeof(int)*8;
    for (digit = 0; digit < maxDigit; digit++, target++) {
	*target = source & 1;
	source >>= 1;
    }
}

void Dec2Oct(int source, int *target) {
    int maxDigit;
    int digit;

    maxDigit = sizeof(int)*8;
    for (digit = 0; digit < maxDigit; digit += 3, target++) {
	*target = source & 7;
	source >>= 3;
    }
}

void Dec2Hex(int source, char *target) {
    int maxDigit;
    int digit;
    maxDigit = sizeof(int)*8;
    for (digit = 0; digit < maxDigit; digit += 4, target++) {
	*target = Dec2HexFunc(source & 15);
	source >>= 4;
    }
}


int main() {
    int i;
    int target;
    int *targetBin;
    int *targetOct;
    char *targetHex;
    int binDigit;
    int octDigit;
    int hexDigit;

    binDigit = sizeof(int)*8;
    octDigit = sizeof(int)*8/3;
    hexDigit = sizeof(char)*8/4;

    targetBin = (int *)xmalloc(sizeof(int)*binDigit);
    targetOct = (int *)xmalloc(sizeof(int)*octDigit);
    targetHex = (char *)xmalloc(sizeof(char)*hexDigit);

    scanf("%d", &target);
    Dec2Bin(target, targetBin);
    Dec2Oct(target, targetOct);
    Dec2Hex(target, targetHex);

    for (i = 0; i < binDigit; i++) {
        printf("%d", targetBin[i]);
    }
    
    return 0;
}
