// Simple factorial calculator - using goto

#include <stdio.h>

int main (void) {
    int n;
    printf("n  = ");
    scanf("%d", &n);

    int fac = 1;
    int i = 1;
    
factorial_loop:
    if (i > n) goto print_output;
    
    fac = fac * i;
    i = i + 1;
    goto factorial_loop;
    
print_output:
    printf("n! = %d\n", fac);
    return 0;
}