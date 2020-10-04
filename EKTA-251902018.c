#include <stdio.h>

float perimeter( float l, float b)
{
return 2*(l+b) ;
}

int main(){

float l, b, p;
printf("Enter the length of rectangle:");
scanf("%f", &l);

printf("\n");

printf("Enter the breadth of rectangle:");
scanf("%f", &b);

printf("\n");

p = perimeter( l, b);
printf("THE PERIMETER OF RECTANGLE IS:%.3f", p);
return 0;

}
