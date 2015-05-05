//  preprocessor directive to support printing to the display
#include <stdio.h>

void welcome();
void convertC2K(double *value);
void convertK2F(double *value);
void convertF2C(double *value);
void run();
char getUnits(int choice);

int checkNotBelowAbs0(int type, double *value);
int getChoice();

int main(int argc, char **args) {
	// Prints out a welcome
	welcome();

	// Run the program
	run();
}

void run() {
	// Initializes values
	double temp = 0.0;
	double temp_new;
	int convertFrom;
	int convertTo;

	// Get the temp input value
	printf("Please enter your tempature value: ");
	scanf("%lf", &temp);
	temp_new = temp;
	
	// Gets the given value units
	printf("Enter Given Tempature Units\n");
	convertFrom = getChoice();

	// Checks if the input is valid
	if(checkNotBelowAbs0(convertFrom, &temp) != 1) {
		printf("Your value is below Absolute Zero and therefore unrealistic.\n");
	} else {
		// Get the desired units
		printf("Enter Desired Units\n");
		convertTo = getChoice();

		char old_unit = getUnits(convertFrom);

		// Loop and keep converting until the value is converted as desired
		while(convertFrom != convertTo) {
			if(convertFrom == 1) convertK2F(&temp_new);
			else if(convertFrom == 2) convertF2C(&temp_new);
			else convertC2K(&temp_new);
			convertFrom = (convertFrom % 3) + 1;
		}
		printf("\nYour original value (%lf %c) converted is %lf %c.\n",
				temp, old_unit, temp_new, getUnits(convertTo));
	}		
}

char getUnits(int choice) {
	if(choice == 1) return 'K';
	else if(choice == 2) return 'F';
	else return 'C';
}

void welcome() {
	printf("Welcome to the tempature converter!\n");
	printf("We cover all of your tempature converting needs.");
	printf(" Have a value in Kelvin, Celsius, or Fahrenheit, but ");
	printf("want your value in another unit? We'll convert it!\n");
	
	printf("\nOf course if your input isn't valid (i.e below");
	printf(" Absolute Zero) we can't help you!\n\n");
}

void convertC2K(double *value) {
	double old = *value;
	*value = old + 273.15;
}

void convertK2F(double *value) {
	double old = *value;
	*value = (old - 273.15) * 1.8000 + 32.00;
}

void convertF2C(double *value) {
	double old = *value;
	*value = (old - 32.0) * (5.0 / 9.0);
}

int checkNotBelowAbs0(int type, double *value) {
	if((type == 1 && *value >= 0.0) || (type == 2 && *value >= -459.67) 
		|| (type == 3 && *value >= -273.15)) {
		return 1;
	} else {
		return 0;
	}
}

int getChoice() {
	int choice = -1;
	
	int count = 0;
	
	while (0 > choice || choice > 3) {
		printf("Please enter the # representing your choice:\n");
		printf("(1) Kelvin\n");
		printf("(2) Fahrenheit\n");
		printf("(3) Celsius\n");
		printf("Choice: ");	

		scanf("%u", &choice);

		if(0 > choice || choice > 3) {
			printf("\nYour choice was not one of the integers 1, 2, or 3.\n");
			printf("Please try again\n\n");
		}
		
		count++;
		if(count > 10) {
			printf("You either entered a String or entered incorrectly too many times.\n");
			printf("The program defaults to Kelvin.\n");
			return 1;
		}
	}
	return choice;
}
