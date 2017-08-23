Exercise #1: Investigate Bit-field Layout

You first task is to determine how the C compiler lays out the bit-fields within a 32-bit word.
We have provided a skeleton for a C program to do this: where_are_the_bits.c.
This program simply defines a struct like the one above, defines a variable of this struct type,
 and then prints its size (which you should be able to determine before running the program).
Add whatever code you want to this program that will allow you to determine conclusively which of the above layouts is used.
Once you've done this, show your tutor how you did it and check that you've come to the right conclusion.
You can assume that the C compiler uses the same layout strategy for all bit-fields within a single word
 for all other structs defined like the above.




Exercise #2: Build Float Values using Bit-fields and Unions

You second task is to implement a way of building float values by inputting 
 an appropriate bit-pattern representing the number according to the IEEE standard.
We have supplied a skeleton program that defines a union type consisting of a 32-bit quantity
 that can be interpreted as either an unsigned int, an unsigned int that has been partitioned
 into three bit-fields, or as a float value.
The program reads three bit-strings from the command-line, corresponding to the (sign,exp,frac)
 components of a floating-point number, stores these values in the union,
 then displays the bit-strings from the union (for debugging),
 and finally displays the contents of the union as a float value.

What you need to do is:

- devise an appropriate bit-field representation
 for floats that will allow you to easily access to components
- complete the getBits() function, which takes bit-strings from the command-line
 and stores them in the appropriate components in a Union32 object
- complete the showBits() function, which converts the bit-strings for the three components
 of a floating point value in a Union32 object into a single C string,
 formatted as in the examples below


