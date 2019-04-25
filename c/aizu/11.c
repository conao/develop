#include <stdio.h>
#include <math.h>

int main() {
    int i;
    int count;
    float x[3], y[3];
    float xpoint, ypoint;
    float r;

    scanf("%d", &count);
    for (i=0; i<count; i++) {
        scanf("%f %f %f %f %f %f", &x[0], &y[0], &x[1], &y[1], &x[2], &y[2]);
        xpoint = (x[0] + x[1] + x[2]) / 3;
        ypoint = (y[0] + y[1] + y[2]) / 3;
        r = sqrt(powf(x[0] - xpoint, 2) + powf(y[0] - ypoint, 2));
        
        printf("%f %f %f\n", xpoint, ypoint, r);
    }
    
    return 0;
}
