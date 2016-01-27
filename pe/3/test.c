#include <stdio.h>

void func(int *index) {
    printf("%d\n", *index);
    *index++;
    func(index);
}

int main() {
    int index = 0;
    func(&index);
    return 0;
}
