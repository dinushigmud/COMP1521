// where_are_the_bits.c ... determine bit-field order
// COMP1521 Lab 03 Exercise
// Written by ...

#include <stdio.h>
#include <stdlib.h>

struct _bit_fields {
   unsigned int a : 4,
                b : 8,
                c : 20;
};

int main(void)
{
   struct _bit_fields x;

   printf("%ul\n",sizeof(x));

   unsigned int *ptr;
   x.a = 0;
   x.b = 0;
   x.c = 0;

   printf("%d\n", x.a);
   printf("%d\n", x.b);
   printf("%d\n", x.c);

   ptr = (unsigned int *)&x;
   (*ptr)++; //may increment either x.a || x.c
	     //depennding on which part is incremented
	     //the value of x.?, when printed, will also change

   printf("%d\n", x.a);
   printf("%d\n", x.b);
   printf("%d\n", x.c);
             //using the value we can determine
	     //the bit field alignment in memory
	     //the answer that comes through is 1 0 0
	     //so, x.a is changed
	     //we know that when incremented the right most bit changes
	     //so, the bit fiels is of the form x.c x.b x.a
   return 0;
}
