// printf関数を使うために必要
#include <stdio.h>

// pow関数を使うために必要
#include <math.h>

// exit関数を使うために必要
#include <stdlib.h>

// ラベルを付ける
#define TRUE 1
#define FALSE 0
#define MAX_DIGIT 8


/******************************
 2進数関連
******************************/
// Change Integer to Binaryの略。10進数から2進数に変換する。整数部のみ対応
// CIntBinが再帰するたびに*pが後ろに行く（桁あがり）
// 初期状態で*pは配列の一番右のポインタである必要がある。
void CIntBin(int *p, int target) {
    if (target == 1) {
        *p = TRUE;
    } else {
        *p = target % 2;  /* TRUE or FLASE */
        CIntBin(--p, (int)(target/2));  /* 小数部切り捨てで再帰 */
    }
}

// Change Float to Binaryの略。10進数から2進数に変換する。小数部のみ対応
// CFloatBinが再帰するたびに*pが前に行く（桁さがり）
// 初期状態で*pは配列の一番左のポインタである必要がある。CIntBinとは逆なので注意。
void CFloatBin(int *p, float target) {
    if (target >= 1) {
        printf("Error at 'CFloatBin'!! target is %.2f > 1.0\n", target);
        exit(1);
    }
    
    target *= 2;
    
    if (target == 1) {
        *p = 1;
    } else if (target > 1) {
        *p = 1;
        CFloatBin(++p, target - 1);  /* 整数部は必ず1 */
    } else {
        *p = 0;
        CFloatBin(++p, target);
    }
}

// Change to Decimalの略。2進数から10進数に変換する。少数にも対応している。
// CDecが再帰するたびにmultiが次々2で割られていく。それをindex回続ける。
// multiは初期状態で2^(整数桁-1)である必要がある。
// 最上位桁から最下位桁までその桁の重みを掛けて、加算する。
float CDec(int *target, float multi, int index) {
    if (index == 1) {
        return *target * multi;
    } else {
        return (*target * multi) + CDec(++target, multi/2, --index);
    }
}

// Reverse Binaryの略。与えられた配列の全ての真偽値を反転する。
// 再帰するたび*pは前に進んでいく。真偽値の否定は!で求めることができる。
void revBin(int *p, int index) {
    if (index == 0) {
        return;
    } else {
        *p = !*p;
        revBin(++p, --index);
    }
}


/******************************
 加算器関連 Wikipedia参照
******************************/
// 半加算器。a,bを受け取り、sを返す。繰り上がりはcで出力する。
void harfAdder(int *a, int *b, int *s, int *c){
    *c = *a && *b;
    *s = (*a || *b) && (!*c);
}

// 全加算器。a,b,cを受け取り、sを返す。繰り上がりは上書きされたcで出力する。
// harfAdderと引数の並びが違うのはWikipedia準拠のため。
void fullAdder(int *a, int *b, int *c, int *s) {
    int tmpa;
    int tmpb;
    
    tmpa = *a;
    tmpb = *b;
    harfAdder(a     ,b ,&tmpa ,&tmpb);
    harfAdder(&tmpa ,c ,s     ,c);
    *c = tmpb || *c;
}

// 与えられた配列の各桁をそれぞれ全加算器に通していく。
// 向きは最下位から最上位桁。cは次の桁に持ち越す。
// 配列aは上書きされて、加算結果が代入される。もともとの配列aは破壊されるが、配列bは破壊されない。
// 初期状態で*a,*bはそれぞれの配列の一番右のポインタであり、変数cは0である必要がある。
// 最上位桁に行ったにも関わらず、繰り上がりしている場合、オーバーフローしているので異常終了。
void adder(int *a, int *b, int *c, int index) {
    if (index == 0) {
        if (*c == 1) {
            printf("Error at 'adder'!! Overflow!!\n");
            exit(1);
        }
        return;
    } else {
        fullAdder(a, b, c, a);
        adder(--a, --b, c, --index);
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
void dispArray(int *target, int index) {
    if (index == 0)  {
        printf("\n");
        return;
    } else {
        printf("%d", *target);
        dispArray(++target, --index);
    }
}

int main() {
    /******************************
     1. 10進数49を2進数で表わせ
    ******************************/

    int target;
    int targetBin[MAX_DIGIT];

    // targetを49で初期化
    target = 49;
    
    // targetBinを0で初期化
    initArray(targetBin, MAX_DIGIT);
    
    // targetを2進数に変換する。結果はtargetBinに代入される
    CIntBin(&targetBin[MAX_DIGIT - 1], target);

    // ラベルとtargetBinの表示
    printf("1.)  49 is ");
    dispArray(targetBin, MAX_DIGIT);
    

    /******************************
     2. 10進数-69を8桁の符号付き2進数（2の補数）で表わせ
    ******************************/

    // int target;
    // int targetBin[MAX_DEGIT];
    int addBin[MAX_DIGIT];
    int c;

    // targetを-69で初期化
    target = -69;

    // 繰り上がり変数の初期化
    c = 0;
    
    // 使用する配列を0で初期化
    initArray(targetBin, MAX_DIGIT);
    initArray(addBin, MAX_DIGIT);
    
    // targetの絶対値を2進数に変換する。結果はtargetBinに代入される
    CIntBin(&targetBin[MAX_DIGIT - 1], (-1) * target);
    
    // 1を2進数に変換する。結果はaddBinに代入される
    CIntBin(&addBin[MAX_DIGIT - 1], 1);
    
    // targetBinの全ての真偽値を反転する
    revBin(targetBin, MAX_DIGIT);
    
    // 加算器にtargetBinとaddBinを放り込む。結果はtargetBinに代入される。
    // 変数cは繰り上がり用の変数。
    adder(&targetBin[MAX_DIGIT - 1], &addBin[MAX_DIGIT - 1], &c, MAX_DIGIT);
    
    // ラベルとtargetBinの表示
    printf("2.) -69 is ");
    dispArray(targetBin, MAX_DIGIT);

    
    /******************************
     3. 10進数0.8125を2進数で表わせ
    ******************************/
    
    // int targetBin[MAX_DEGIT];
    float targetFlort;

    // targetFloatを0.8125で初期化
    targetFlort = 0.8125;
    
    // targetBinを0で初期化
    initArray(targetBin, MAX_DIGIT);
    
    // targetFloatを2進数に変換する。結果はtargetBinに代入される。
    CFloatBin(targetBin, targetFlort);
    
    // ラベルとtargetBinの表示
    printf("3.) 0.8125   is 0.");
    dispArray(targetBin, MAX_DIGIT);

    
    /******************************
     4. 2進数101.1001を10進数で表わせ
    ******************************/
    
    // tmpBinの初期化
    int tmpBin[] = {1,0,1,1,0,0,1};
    int intPartDegit;
    int allDegit;

    // 整数部の桁数
    intPartDegit = 3;
    
    // 全体の桁数
    allDegit = 7;
    
    // ラベルの出力後、CDec関数でfloat型に変換したものを直接出力する
    printf("4.) 101.1001 is %f\n", CDec(tmpBin, pow(2, intPartDegit - 1), allDegit));


    /******************************
     5. 符号付き2進数 1101001を10進数で表わせ
    ******************************/
    
    // int c;
    // int allDegit;
    // addBin[MAX_DEGIT];

    // signedBinの初期化
    int signedBin[] = {1,1,0,1,0,0,1};

    // ラベルの出力
    printf("5.) signed   1101001 is ");
    
    if (tmpBin[0] == 0) {  // 最上位ビットがFalseの場合
        // 全体の桁数（整数部の桁数）
        allDegit = 7;
    
        printf("%f\n", CDec(signedBin, pow(2, allDegit - 1), allDegit));
        
    } else {               // 最上位ビットがTrueの場合
        // 全体の桁数（整数部の桁数）
        allDegit = 7;
        
        // 繰り上がり変数の初期化
        c = 0;
        
        // addBinの初期化
        initArray(addBin, allDegit);

        // signedBinの全ての真偽値を反転する。
        revBin(signedBin, allDegit);

        // 1を2進数に変換する。結果はaddBinに代入される。
        CIntBin(&addBin[allDegit - 1], 1);
        
        // 加算器にsignedBinとaddBinを放り込む。結果はsignedBinに代入される。
        // 変数cは繰り上がり用の変数
        adder(&signedBin[allDegit - 1], &addBin[allDegit - 1], &c, allDegit);
        
        // CDec関数でfloat型に変換したものに-1を乗算して出力する。
        printf("%.0f\n", -1 * CDec(signedBin, pow(2, allDegit - 1), allDegit));
    }

    
    /******************************
     6. 符号なし2進数  1101001を10進数で表わせ
    ******************************/
    
    // int allDegit;
    int unsignedBin[] = {1,1,0,1,0,0,1};

    // 全体の桁数（整数部の桁数）
    allDegit = 7;

    // ラベルの出力後、CDec関数でfloat型に変換したものを出力する。
    printf("6.) unsigned 1101001 is %.0f\n", CDec(unsignedBin, pow(2, allDegit - 1), allDegit));

    return 0;
}
