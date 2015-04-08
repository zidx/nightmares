//  preprocessor directive to support printing to the display
#include <stdio.h>

//  function protorypes

int getData(void);				//  takes no args and returns a variable of type int

int compute(int myData);		//  takes one arg or type int and returns a variable 
								//  of type int

void showValue(int aResult);	//  takes one arg or type intand returns nothing

//  the main program
int main(void)
{
	//  declare, define, and initialize some working variables
	int aValue = 0;
	int aResult = 0;

	//  call getData() to get data from user
	//  assign returned value to aValue
	aValue = getData();

	//  call compute() to perform a computation on aValue
	//  assign returned value to aResult
	aResult = compute(aValue);

	//  call showValue() to display aResult.
	//  no value is returned
	showValue(aResult);

	return 0;

}

//  function getData() requests data from user 
//  returns variable of type int to user
int getData(void)
{
	//  declare, define, and initialize working variable
	int temp = 0;
	
	// ask the user for some data
	printf("please enter a value\n");

	// get the data from the user
	//  the data will be an integer number: %d
	//  stored in the variable 'temp'
	//  the & operator takes the address of the variable 'temp'
	scanf("%d", &temp);

	// remove newline from input buffer
	getchar();

	// return temp to user
	return temp;
}


//  function compute(int myData) adds 2 to data passed in from user 
//  returns variable of type int to user
int compute(int myData)
{
	//  declare, define, and initialize working variable
	int temp = 0;

	//  add 2 to myData and assign result to temp
	temp = myData + 2;

	// return temp to user
	return temp;

}

//  function showValue(int aResult) prints the data passed in to the display 
//  returns nothing
void showValue(int aResult)
{
	//  print the user data to the display 
	//    the format will be x
	printf("the result is: %d\n", aResult);

	return;
}