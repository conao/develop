#include <stdio.h>

// 既約分数を表示するプログラム
// malloc使わない版

// num is numerator, deno is denominator
typedef struct {int num; int deno;} fraction;

int gcd (int x, int y) {
  while (x != 0 && y != 0)
    if (x > y) x = x % y; else y = y % x;
  if (x > y) return x; else return y;
}

int main (void) {
  fraction A, B, C;

  printf("> ");

  scanf("%d,%d,%d,%d", &A.num, &A.deno, &B.num, &B.deno);
  C.num = A.num*B.deno + B.num*A.deno;
  C.deno = A.deno*B.deno;
  C.num = C.num / gcd(C.num, C.deno);
  C.deno = C.deno / gcd(C.num, C.deno);
  printf("%d,%d\n", C.num, C.deno);
  return 0;
}
