#include <stdio.h>

// Sunny, Cloudy, Rainy
int main () {
  char s[100];
  scanf("%s", s);
  if (s[0] == 'S') {
    printf ("Cloudy\n");
  } else if (s[0] == 'C') {
    printf ("Rainy\n");
  } else {
    printf ("Sunny\n");
  }
}
