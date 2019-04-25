#include<stdio.h>

int main(){
    char s1[] = "ABC2";
    char s2[] = "ABCD";
    int i = 0;
    while (s1[i] == s2[i] && s1[i] != '\0')
        i++;
    if (s1[i] == '\0' || s1[i] < s2[i])
        printf("%s\n", s1);
    else if (s2[i] == '\0' || s1[i] > s2[i])
        printf("%s\n", s2);
    return 0;
}
