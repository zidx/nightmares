//  preprocessor directive to support printing to the display
#include <stdio.h>

void part1();

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
	int intB = 0;

	// Declare variables of type float
	float floatA = 0.0;
	float floatB = 0.0;

	// Declare variables of type char
	char charA = '';
	char charB = '';

	// Declare all pointer types
	// Initialize to the addresses of our above variables 
	// in the same line
	int *intPointA = &intA;
	int *intPointB = &intB;

	float *floatPointA = &floatA;
	float *floatPointB = &floatB;

	char *charPointA = &charA;
	char *charPointB = &charB;

	// Print addresses all variables
	printf("Address of int A: %p\n", intPointA);
	printf("Address of int B: %p\n", intPointB);

	printf("Address of float A: %p\n", floatPointA);
	printf("Address of float B: %p\n", floatPointB);

	printf("Address of char A: %p\n", charPointA);
	printf("Address of char B: %p\n", charPointB);
}

void part2() {
	// Declare and initialize integers
	int a = 22, b = 17, c = 6, d = 4, e = 9;
	int result = 0;

	// Declare and initialize pointers to variables
	int aPoint = &a;
	int bPoint = &b;
	int cPoint = &c;
	int dPoint = &d;
	int ePoint = &e;

	// Compute ((A - B)*(C+D))/E using pointers
	result = ((*aPoint - *bPoint) * (*cPoint + *dPoint)) / *ePoint;

	// Print result
	printf("Result of computation is %d\n", result);
}