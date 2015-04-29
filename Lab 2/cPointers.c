// cPointers tests pointers in C using two functions:
//   Part1: 
//		Tests memory address printing and value dereference
//   Part2:
//		Tests integer computation with dereferenced pointers
//
//   Author (s):
//	 Zach Nehrenberg
//   Krista Holden

//  preprocessor directive to support printing to the display
#include <stdio.h>

// Tests memory address retrieval
void part1();

// Tests dereferenced pointer arithmetic
void part2();

int main(int argc, char *args) {
	// Run both parts and print output
	part1();
	part2();
}

void part1() {
	// Although we are not using the varibales' values, it is always
	// better to initialize a variable that is not a pointer when it
	// is declared.
	// Declaring variables of type int
	int intA = 0;
	int intB = 1;

	// Declare variables of type float
	float floatA = 0.0;
	float floatB = 1.0;

	// Declare variables of type char
	char charA = 'a';
	char charB = 'b';

	// Declare all pointer types
	int *int_ptr;
	float *float_ptr;
	char *char_ptr;
	
	// Print values all variables
	// "Print out the value"
	int_ptr = &intA;
	printf("Value of int A at address %p: %i\n", int_ptr, *int_ptr);
	
	int_ptr = &intB;
	printf("Value of int B at address %p: %i\n", int_ptr, *int_ptr);

	float_ptr = &floatA;
	printf("Value of float A at address %p: %f\n", float_ptr, *float_ptr);
	
	float_ptr = &floatB;
	printf("Value of float B at address %p: %f\n", float_ptr, *float_ptr);

	char_ptr = &charA;
	printf("Value of char A at address %p: %c\n", char_ptr, *char_ptr);
	
	char_ptr = &charB;
	printf("Value of char B at address %p: %c\n", char_ptr, *char_ptr);
}

void part2() {
	// Declare and initialize integers
	int a = 22, b = 17, c = 6, d = 4, e = 9;
	int result = 0;

	// Declare and initialize pointers to variables
	int *aPoint = &a;
	int *bPoint = &b;
	int *cPoint = &c;
	int *dPoint = &d;
	int *ePoint = &e;

	// Compute ((A - B)*(C+D))/E using pointers
	result = ((*aPoint - *bPoint) * (*cPoint + *dPoint)) / *ePoint;

	// Print result
	printf("Result of computation is %d\n", result);
}
