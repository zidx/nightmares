/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"

#define rtd (volatile char *) 	 	 0x0003060
#define outSignal (volatile char *)  0x0003050
#define curByteOut (volatile char *) 0x0003040
#define inStrobe (volatile char *)   0x0003030
#define load (volatile char *) 		 0x0003020
#define curByteIn (volatile char *)  0x0003010
#define hempTea (volatile char *)    0x0003000

#define MAX_GUESSES 12  // Corresponds to correct and incorrect guesses
#define WIN_VAL 254
#define LOSE_VAL 253
#define DATA_RECIEVED 255

// For setWord. This makes this easier
//char word[20];
//alt_u8 letterCount;


void sendData(alt_u8 data);
alt_u8 recieveData();
void game_master();
void player();
alt_u8 setWord(char * word);
alt_u8 startGame(alt_u8 letterCount);



int main() {
	// Must reset everything, even the things we're not using
	IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x0);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0x0);
	IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x0);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0x0);

	char start = 'a';
	while(start != 'M' && start != 'P') {
		alt_putstr("Enter an 'M' to be game master or 'P' to be a player\n");
		start = alt_getchar();
	}

	if (start == 'M')
		while (1)
			game_master();
	else if (start == 'P')
		while (1)
			player();

	return 0;
}

void game_master() {
	// Set word
	alt_getchar();  // Recieve dummy byte
	char word[20];
	int j;
	for (j = 0; j < 20; j++) {
		word[j] = '\n';
	}
	alt_u8 letterCount = setWord(word);

	// Word placements
	alt_u8 letterPlacement[letterCount];

	for (j = 0; j < letterCount; j++) {
		letterPlacement[j] = 0;
	}

	// Now we recieve input from the player and check it
	int guesses = 0;
	int win = 0;
	alt_u8 guessedLetters[MAX_GUESSES];  // Already guessed letters
	for (j = 0; j < MAX_GUESSES;  j++) {
		guessedLetters[j] = '\n';
	}

	// Send to the player to say that we're ready for guesses
	// We use 255 for send
	// Wait for the return signal from the player so we know to start the game
	// If we don't get this, something has gone wrong and we need to retry
	startGame(letterCount);

	// Now we are ready to wait to recieve data
	alt_u8 guess;
	alt_u8 retVal;
	int lettersCorrect;
	while (!win && guesses < MAX_GUESSES) {
		alt_putstr("Waiting for next guess\n");
		guess = recieveData();
		alt_putstr("Guess recieved\n");

		int i;
		retVal = 0; // 1 - letterCount == correct, 0 == wrong, letterCount+1 = alreadyGuessed

		// Check if the letter is already guessed
		for (i = 0; i < guesses; i++) {
			if (guessedLetters[i] == guess) {
				alt_putstr("This letter has already been guessed!\n");
				retVal = letterCount+1;
			}
		}
		if (retVal == 0) {
			guessedLetters[guesses] = guess;
			for (i = 0; i < letterCount; i++) {
				if (word[i] == guess) {
					retVal++;
					letterPlacement[i] = 1;
				}
			}
			// Increment guess value
			guesses++;
		}

		// Display letter placements
		lettersCorrect = 0;
		alt_putstr("Word: ");
		for (i = 0; i < letterCount; i++) {
			if (letterPlacement[i] == 1) {
				alt_printf("%c ", word[i]);
				lettersCorrect++;
			} else
				alt_putstr("_ ");
		}
		alt_putstr("\nGuessed Letters: ");
		for (i = 0; i < guesses; i++) {
			if (i == 0)
				alt_printf("%c", guessedLetters[i]);
			else
				alt_printf(", %c", guessedLetters[i]);
		}
		alt_putstr("\n\n");

		// Check if win is true
		if (lettersCorrect == letterCount) {
			win = 1;
			break;
		}
		else if (guesses == MAX_GUESSES) {
			break;
		}

		// Send back the guessed answer
		sendData(retVal);
		recieveData();

		// Send back how many guesses remain
		sendData(MAX_GUESSES - guesses);
		recieveData();

		// Now send the word
		for (i = 0; i < letterCount; i++) {
			if (letterPlacement[i] == 1) {
				sendData(word[i]);
			}
			else {
				sendData('_');
			}
			recieveData();  //Confirmation
		}

		// Now send guesses
		for (i = 0; i < guesses; i++) {
			recieveData();
			sendData(guessedLetters[i]);
		}
	}

	// Check win condition
	if (lettersCorrect == letterCount) {
		sendData(WIN_VAL);
		//alt_getchar();
		alt_putstr("Player won!\nPress a character to play again\n");
		alt_getchar();
		//break;
	}
	else {
		sendData(LOSE_VAL);
		//alt_getchar();
		alt_putstr("Player Lost\nPress a character to play again\n");
		alt_getchar();
		//break;
	}
}

void player() {
	// Wait for the code that the master is ready
	int wordLen = recieveData();
	alt_u8 guessesRemaining = MAX_GUESSES;
	// Send that we got the word and are about to play
	sendData(DATA_RECIEVED);

	while (1) {
		// Now we are ready to send guesses!
		alt_getchar();
		alt_putstr("Please enter a letter and press enter\n");
		alt_u8 letter = alt_getchar();

		// Send the letter

		sendData(letter);

		// Get the response
		alt_u8 response = recieveData();

		if (response == WIN_VAL) {
			alt_putstr("Congratulations you won!\n");
			break;
		}
		else if (response == LOSE_VAL) {
			alt_putstr("You lost because you have no friends and your life is\nmeaningless and you smell bad.\nWaiting for new game...\n");
			break;
		}
		// If we come here than we're in normal gameplay
		sendData(DATA_RECIEVED);
		guessesRemaining = recieveData();

		if (response == 0) {
			alt_printf("Sorry, the letter '%c' was incorrect\n", letter);
		}
		else if (response <= wordLen) {
			alt_printf("The letter '%c' was correct and filled %x places!\n", letter, response);
		}
		else
			alt_printf("You already guessed the letter '%c'!\n", letter);
		int numGuesses = MAX_GUESSES - guessesRemaining;
		// Acknowledge last data recieved
		sendData(DATA_RECIEVED);

		// Print out the characters
		alt_putstr("Word: ");
		int i;
		for (i = 0; i < wordLen; i++) {
			letter = recieveData();
			alt_printf("%c ", letter);

			sendData(DATA_RECIEVED);
		}
		alt_putstr("\nGuessed characters: ");

		//acknowledgement for ready to recieve before recieving
		for (i = 0; i < numGuesses; i++) {
			sendData(DATA_RECIEVED);

			letter = recieveData();

			if (i == 0)
				alt_printf("%c", letter);
			else
				alt_printf(", %c", letter);
			//alt_printf("sent data recieved\n");

		}
		alt_putstr("\n");

		alt_printf("You now have '%x' guesses remaining.\n\n", guessesRemaining);
	}
}


alt_u8 setWord(char * word) {
	alt_putstr("Please enter your word (Max 20 letters):\n");
	char letter = '#';
	alt_u8 letterCount = 0;
	while ((letter = alt_getchar()) != '\n') {
		word[letterCount] = letter;
		letterCount++;
	}
	return letterCount;
}

// Retries the send/recieve pattern after a timeout
// until data is recieved.
alt_u8 startGame(alt_u8 letterCount) {
	int timeout = 0;
	do {
		alt_u8 retVal = 0;
		int wait = 0;
		sendData(letterCount);
		alt_u8 strobe = IORD_ALTERA_AVALON_PIO_DATA(inStrobe);
		while (strobe == 0) {
			strobe = IORD_ALTERA_AVALON_PIO_DATA(inStrobe);
			wait++;
			if (wait == 2000000) {
				alt_putstr("Player waiting timeout. Retrying...\n");
				timeout = 1;
				break;
			}
		}
		if (strobe == 1) {
			retVal = IORD_ALTERA_AVALON_PIO_DATA(curByteIn);
			if (retVal == DATA_RECIEVED) {	// Value to show data was received
				while (strobe == 1) {
					strobe = IORD_ALTERA_AVALON_PIO_DATA(inStrobe);
				}
				return 1;
			}
			else {
				timeout = 1;
			}
			timeout = 0;
		}
		wait = 0;
	} while (timeout == 1);

	// Should never get here
	return 0;
}

alt_u8 recieveData() {
	alt_u8 strobe = IORD_ALTERA_AVALON_PIO_DATA(inStrobe);
	while (strobe == 0) {
		strobe = IORD_ALTERA_AVALON_PIO_DATA(inStrobe);
	}
	alt_u8 retVal = IORD_ALTERA_AVALON_PIO_DATA(curByteIn);
	while (strobe == 1) {
		strobe = IORD_ALTERA_AVALON_PIO_DATA(inStrobe);
	}
	return retVal;
}


void sendData(alt_u8 data) {
	alt_u8 empty = 0;
	//sends data to camera
	IOWR_ALTERA_AVALON_PIO_DATA(curByteOut, data);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0x1);

	empty = IORD_ALTERA_AVALON_PIO_DATA(hempTea);
	while (empty == 0) {
		empty = IORD_ALTERA_AVALON_PIO_DATA(hempTea);
	}
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0x0);
}
