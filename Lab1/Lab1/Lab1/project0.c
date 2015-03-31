//  preprocessor directive to support printing to the display
#include <stdio.h>

//  the main program
int main(void)
{
	//  declare, define, and initialize some working variables
	double manCost = 0.0;
	double markUp = 0.0;
	double tax = 0.0;
	double preTaxDiscount = 0.0;
	double listPrice = 0.0;

	// Ask the user for manufacture cost, mark up, tax,
	// and any discounts. Store all the data in doubles
	// (just in case it's a REALLY expensive car like 
	// a Ferrari La Ferrari)
	printf("What is the manufacturer's cost?\n");
	scanf("%lf", &manCost);

	printf("What is the dealer's markup?\n");
	scanf("%lf", &markUp);

	printf("What is the sales tax?\n");
	scanf("%lf", &tax);

	printf("What is the dealer's pre-tax discount?\n");
	scanf("%lf", &preTaxDiscount);

	// Compute the estimated list price
	listPrice = manCost + markUp + tax - preTaxDiscount;

	// Present the findings to the user
	printf("The estimated list price of your car is %.2f\n", listPrice);
	return 0;
}


