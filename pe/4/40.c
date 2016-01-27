#include <stdio.h>
#include <math.h>

double ans[2];
double real;
double comp;

void calcSoleAns(double a, double b, double c) {
    ans[0] = (1/(2*a))*(-1)*b;
    return;
}

void calcComplexAns(double a, double b, double c) {
    real = (1/(2*a))*(-1)*b;
    comp = (1/(2*a))*sqrt(b*b-4*a*c);
    return;
}

void calcAns(double a, double b, double c) {
    ans[0] = (1/(2*a))*((-1)*b+sqrt(b*b-4*a*c));
    ans[1] = (1/(2*a))*((-1)*b-sqrt(b*b-4*a*c));
    return;
}

void calcLinearAns(double b, double c) {
    ans[0] = c/b;
    return;
}

double D(double a, double b,double c){
    double d;
    d = b*b - 4.0*a*c;
    return d; 
}

int main() {
    double a, b, c, d;
    
    printf("calc x.\nax^2+bx+c=0\n");
    printf("Input a...");
    scanf("%lf", &a);

    printf("Input b...");
    scanf("%lf", &b);

    printf("Input c...");
    scanf("%lf", &c);
    printf("x = ");
    
    if (a = 0) {
        calcLinearAns(b, c);
        printf("%lf\n", ans[0]);
    } else {
        d = D(a,b,c);
        if(d > 0) {
            calcAns(a, b, c);
            printf("%lf, %lf\n", ans[0], ans[1]);
        } if (d < 0) {
            calcComplexAns(a, b, c);
            printf("%lf+%lfi, %lf-%lfi\n", real, comp, real, comp);
        } else {
            calcSoleAns(a, b, c);
            printf("%lf\n", ans[0]);
        }
    }
    
    return 0; 
}
