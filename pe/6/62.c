#include <stdio.h>

int sum(int *a, int n) {
    int i;
    int s = 0;
    for(i = 0; i < n; i++){
        // *(a + i)は配列aの一番最初から右にiずれた変数を返す
        s += *(a + i);
    }
    return s;
}

int main() {
    int a[] = {3, 10, 4, 1, 5, 9, 2, 6, 5};
    
    printf("sum=%d\n", sum(a, sizeof(a) / sizeof(*a)));
    return 0;
}
