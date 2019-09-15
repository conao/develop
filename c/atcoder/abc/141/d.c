#include <stdio.h>

int main () {
  long int i, j, tmp, max, sum, n, m;
  long int a[100001];

  scanf("%ld %ld", &n, &m);

  for (i = 0; i < n; i++) {
    scanf("%ld ", &a[i]);
  }

  for (i = 0; i < m; i++) {
    /* for (j = 0; j < n; j++) printf("%ld,", a[j]); */
    /* printf("\n"); */
    
    for (j = 0, max = -1; j < n; j++) {
      if (max < a[j]) max = a[j], tmp = j;
    }
    a[tmp] /= 2;
  }

  /* for (j = 0; j < n; j++) printf("%ld,", a[j]); */
  /* printf("\n"); */

  for (i = 0, sum = 0; i < n; i++) {
    sum += a[i];
  }
  printf("%ld\n", sum);
}
