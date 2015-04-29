//  preprocessor directive to support printing to the display
#include <stdio.h>
#include <stdint.h>

void welcome();
int getChoice();
void run();
void debug();
int verify(int val, int exp, int act);
int calculate(int num_devices);

int main(int argc, char **args) {
	// Prints out a welcome
	welcome();

	// Run the program
	if (argc > 1) {
		printf("\nYou are running in debug mode.\n");
		debug();
	} else {
		run();
	}
}

void run() {
	// Initializes values
	int delay = 0;	
	int num_devices = 0;

	// Get the number of devices input value
	num_devices = getChoice();

	// Calculate delay
	delay = calculate(num_devices);

	// Output delay
	printf("\nYour circuit has a delay of %d picoseconds.\n\n", delay);
}

int calculate(int num_devices) {
	return 18 * (num_devices + 1) + 5000 * (num_devices);
}

void debug() {
	int exp = 18;
	int i;
	
	int passed = 0;
	
	for(i = 0; i < 9; i++) {
		passed += verify(i, calculate(i), exp);
		exp += 18 + 5000;
	}

	passed += verify(800, calculate(800), 4014418);
	passed += verify(50000, calculate(50000), 250900018);
	
	printf("\nYou passed all the tests.\n\n");
}

int verify(int val, int exp, int act) {
	if(exp != act) {
		printf("Test failed for input value %d\nExp: %d\nAct: %d\n", val, exp, act);
		return 1;
	} else {
		return 0;
	}
}

void welcome() {
	printf("Welcome to the Logic Device Delay!\n");
	printf("We cover all of your delay calculating needs.");
	printf(" Have a signal path with logic devices, but ");
	printf("don't know your total delay? We'll find it!\n");

	printf("\nWe assume that there are printed circuit traces ");
	printf("on both side of the exterior logic gates and that ");
	printf("in the case of no logic gates that there is one ");
	printf("circuit board trace.\n");

	printf("\nOf course if your input isn't valid (i.e ");
	printf("negative num of devices) we can't help you!\n\n");
}

int getChoice() {
	int choice = -1;
	while (0 > choice) {
		printf("Please enter your # of logic devices: ");
		scanf("%u", &choice);

		if(0 > choice) {
			printf("\nYour choice was either not a positive integer\n");
			printf("or too large and caused overflow.\n");
			printf("Please try again\n\n");
		}
	}
	
	printf("\nYou have entered %d logic devices.", choice);
	
	return choice;
}
