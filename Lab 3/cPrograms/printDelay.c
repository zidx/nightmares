//  preprocessor directive to support printing to the display
#include <stdio.h>
#include <stdint.h>

void welcome();
int getChoice();
void run();
void debug();
int verify(int val, double exp, double act);
double calculate(int num_devices);


int main(int argc, char **args) {
	// Prints out a welcome
	welcome();

	// Run the program
	if (argc > 1) {
		debug();
	} else {
		run();
	}
}

void run() {
	// Initializes values
	double delay = 0.0;
	int num_devices = 0;

	// Get the number of devices input value
	num_devices = getChoice();

	// Calculate delay
	delay = calculate(num_devices);

	// Output delay
	printf("\nYour circuit with %d devices has a delay of %lf picoseconds.\n\n", num_devices, delay);
}

double calculate(int num_devices) {
 	return 18.0 * (num_devices + 1) + 5000.0 * (num_devices);
}

void debug() {
	printf("\nYou are running in debug mode.\n");
	int exp = 18;
	int i;
	
	int passed = 0;
	
	for(i = 0; i < 9; i++) {
		passed += verify(i, calculate(i), exp);
		exp += 18.0 + 5000.0;
	}

	passed += verify(800, calculate(800), 4014418.0);
	passed += verify(50000, calculate(50000), 250900018.0);
	
	printf("\nYou passed all the tests.\n\n");
}

int verify(int val, double exp, double act) {
	if(exp != act) {
		printf("Test failed for input value %d\nExp: %f\nAct: %f\n", val, exp, act);
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
	int count = 0;
	while (0 > choice) {
		if(count > 10) {
			printf("\nYou have entered a string or given incorrect input > 10 times.");
			printf("\nDefault value selected: 0.\n");
			return 0;
		}
		
		printf("Please enter your # of logic devices: ");
		scanf("%u", &choice);

		if(0 > choice) {
			printf("\nYour choice was either not a positive integer\n");
			printf("or too large and caused overflow.\n");
			printf("Please try again\n\n");
		}
		count++;
	}
	
	printf("\nYou have entered %d logic devices.\n", choice);
	
	return choice;
}
