#include <stdio.h>

int min(int *a, int n) {
    int i;
    int min;

    // ひとまず最初の値を最小値とみなす 
    min = *a;
    for(i = 1; i < n; i++){
        // minより小さい数が現れたらその値で更新する
        min = min > *(a + i) ? *(a + i) : min;
    }
    return min;
}

int main() {
    int a[] = {3, 10, 4, 1, 5, 9, 2, 6, 5};
    
    printf("min=%d\n", min(a, sizeof(a) / sizeof(*a)));
    return 0;
}
