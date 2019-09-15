#include <stdio.h>

int main () {
  long int i, j, l, a, n, k, q;
  int p[100001];
  int *pp[100001];

  scanf("%ld %ld %ld", &n, &k, &q);
  for (i = 0; i < n; i++) {
    p[i] = k;
    pp[i] = &p[i];
  }

  for (i = 0; i < q; i++) {
    scanf("%ld", &a);

    /* for (l = 0; l < n; l++) printf("%d,", p[l]); */
    /* printf(" "); */
    /* for (l = 0; l < n; l++) printf("%d,", p[l]); */
    /* printf("\n"); */

    for (j = 0; j < n; j++) {
      if (pp[j] && j != a-1) {
        if (--(*pp[j])<=0) pp[j] = NULL;
      }
    }
  }

  for (i = 0; i < n; i++) {
    if (p[i] <= 0) printf("No\n"); else printf("Yes\n");
  }
}
