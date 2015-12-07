#include <stdio.h>

double D(double a, double b, double c){
    double d;
    d = b*b - 4.0*a*c;
    return d; 
}

int main(){
    double a, b, c, d;
    a = 1.0; 
    b = 5.0;
    c = 6.0;
    d = D(a,b,c);
    printf("d = %lf¥n", d);
    return 0; 
}
