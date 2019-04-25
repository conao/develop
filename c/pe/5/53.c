#include<stdio.h>

int mystrcmp(char s1[], char s2[]) {
    int i = 0;
    while (s1[i] == s2[i] && s1[i] != '\0')
        i++;
    if (s1[i] == '\0' || s1[i] < s2[i])       // s1のほうが辞書順で前の時
        return -1;
    else if (s2[i] == '\0' || s1[i] > s2[i])  // s2のほうが辞書順で後ろの時
        return 1;
    return 0;
}

int main(){
    char s1[] = "ACB2";
    char s2[] = "ABCD";
    int i = 0;

    // mystrcmpの結果をiに代入する
    i = mystrcmp(s1, s2);
    if (i < 0){
        printf("%s\n", s1);
    }else if (i > 0){
        printf("%s\n", s2);
    }else{
        printf("%s\n", s1);
    }
    return(0);
}
