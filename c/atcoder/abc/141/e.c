#include <stdio.h>
#include <string.h>

int main () {
  int n, start, len;
  char s[5001], search[5001];
  
  scanf("%d", &n);
  scanf("%s", s);

  printf("%d, %s\n", n, s);
  for (start = 0; start < n; start++) {
    for (len = 0; start+len < n; len++)
      printf("%s\n", strstr(&s[start+len], &s[start]));
  }
}
