//  preprocessor directive to support printing to the display
#include <stdio.h>
#include <stdint.h>

void welcome();
uint32_t getChoice();
void run();
void debug();
void verify(uint32_t val, uint32_t exp, uint32_t act);
uint32_t calculate(uint32_t num_devices);

int main(uint32_t argc, char **args) {
	// Prints out a welcome
	welcome();

	// Run the program
	if (argc > 2)
		debug();
	else
		run();
}

void run() {
	// Initializes values
	uint32_t delay = 0;	
	uint32_t num_devices = 0;

	// Get the number of devices input value
	num_devices = getChoice();

	// Calculate delay
	delay = calculate(num_devices);

	// Output delay
	printf("\n Your circuit has a delay of %d picoseconds.", delay);
}

uint32_t calculate(uint32_t num_devices) {
	return 18 * (num_devices + 1) + 5000 * (num_devices);
}

void debug() {
	uint32_t exp = 18;
	uint32_t i;
	for(i = 0; i < 9; i++) {
		verify(i, calculate(i), exp);
		exp += 18 + 5000;
	}

	verify(800, calculate(800), 4014418);
	verify(50000, calculate(50000), 250900018);
}

void verify(uint32_t val, uint32_t exp, uint32_t act) {
	if(exp != act)
		printf("Test failed for input value %d\nExp: %d\nAct: %d\n", val, exp, act);
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

uint32_t getChoice() {
	uint32_t choice = -1;
	while (0 > choice) {
		printf("Please enter your # of logic devices: ");
		scanf("%u", &choice);

		if(0 > choice || choice > 4) {
			printf("\nYour choice was not a positive uint32_teger.\n");
			printf("Please try again\n\n");
		}
	}
	return choice;
}
