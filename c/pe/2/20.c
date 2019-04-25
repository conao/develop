#include <stdio.h>
int main()
{
    float a, b;
    int i;
    a = 1e+7;     /* 10^7 を a に代入*/
    b = 1e+8;     /* 10^8 を b に代入*/
    printf("a    = %f, b    = %f\n",a,b);
    for(i=1;i<=10;i++) { /* a,bに1を加えて順に表示する */
        a++;
        b++;
        printf("a+%2d = %f, b+%2d = %f\n",i,a,i,b);
    }
    return 0;
}
