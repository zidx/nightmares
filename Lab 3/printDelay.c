//  preprocessor directive to support printing to the display
#include <stdio.h>

void welcome();
int getChoice();
void run();

int main(int argc, char *args) {
	run();
}

void run() {
	// Prints out a welcome
	welcome();

	// Initializes values
	int delay = 0;	
	int num_devices = 0;

	// Get the number of devices input value
	num_devices = getChoice();

	// Calculate delay
	delay = 18 * (num_devices + 1) + 5000 * (num_devices);

	// Output delay
	printf("\n Your circuit has a delay of " + delay + "picoseconds.");
}

void welcome() {
	printf("Welcome to the Logic Device Delay!\n");
	printf("We cover all of your delay calculating needs."
		+ " Have a signal path with logic devices, but "
		+ "don't know your total delay? We'll find it!\n");

	printf("\nWe assume that there are printed circuit traces "
		+ "on both side of the exterior logic gates and that "
		+ "in the case of no logic gates that there is one "
		+ "circuit board trace.\n");

	printf("\nOf course if your input isn't valid (i.e "
		+ "negative num of devices) we can't help you!\n\n");
}

int getChoice() {
	int choice = -1;
	while (0 > choice) {
		printf("Please enter your # of logic devices: ");
		scanf("%u", &choice);

		if(0 > choice || choice > 4) {
			printf("\nYour choice was not a positive integer.\n");
			printf("Please try again\n\n");
		}
	}
	return choice;
}
