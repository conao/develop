#include <stdio.h>

// L, R, U, D

int proc(char *s, int isodd) {
  if (s[0] == '\0') return 1;
  
  if (isodd == 1) {
    if (!(s[0] == 'R' || s[0] == 'U' || s[0] == 'D')) return 0;
  } else {
    if (!(s[0] == 'L' || s[0] == 'U' || s[0] == 'D')) return 0;
  }

  if (proc (++s, (isodd+1) % 2) == 0) return 0; else return 1;
}

int main() {
  char s[100];
  scanf("%s", s);

  if (proc(s, 1) == 1) printf("Yes\n"); else printf("No\n");
}
