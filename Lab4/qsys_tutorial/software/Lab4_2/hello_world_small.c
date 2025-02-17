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

#define leds (volatile char *)        0x0003080
#define switches (volatile char *)    0x0003070
#define outSignal (volatile char *)   0x0003050

#define rtd1 (volatile char *)        0x0003060
#define curByte1 (volatile char *)    0x0003040

#define rtd2 (volatile char *)        0x0003030
#define curByte2 (volatile char *)    0x0003020

#define strobeRead1 (volatile char *) 0x0003010
#define strobeRead2 (volatile char *) 0x0003000

int main()
{
	alt_u8 readyToDownload1;
	alt_u8 readyToDownload2;
	alt_u8 curOutSignal;

	alt_putstr("Welcome to the Camera Control System\n");

	alt_u8 curByte1val = IORD_ALTERA_AVALON_PIO_DATA(curByte1);
	alt_u8 curByte2val = IORD_ALTERA_AVALON_PIO_DATA(curByte2);

	alt_putstr("Here to help your spying needs.\n");

	alt_u8 strobeRead1val = IORD_ALTERA_AVALON_PIO_DATA(strobeRead1);
	alt_u8 strobeRead2val = IORD_ALTERA_AVALON_PIO_DATA(strobeRead2);

	alt_putstr("use safely and carefully!\n");

	alt_u8 prev1 = strobeRead1val;
	alt_u8 prev2 = strobeRead2val;

	IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x0);
	char start = 'a';
	while(start != 'S') {
		alt_putstr("Enter a S to begin the process: ");
		start = alt_getchar();
	}
	IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x2);

	while (1) {
		readyToDownload1 = IORD_ALTERA_AVALON_PIO_DATA(rtd1);
		readyToDownload2 = IORD_ALTERA_AVALON_PIO_DATA(rtd2);

		curByte1val = IORD_ALTERA_AVALON_PIO_DATA(curByte1);
		curByte2val = IORD_ALTERA_AVALON_PIO_DATA(curByte2);

		strobeRead1val = IORD_ALTERA_AVALON_PIO_DATA(strobeRead1);
		strobeRead2val = IORD_ALTERA_AVALON_PIO_DATA(strobeRead2);

		curOutSignal = IORD_ALTERA_AVALON_PIO_DATA(outSignal);

		if(prev1 != strobeRead1val) {
			if (curByte1val == 0x0a)
				alt_printf("Downloading buffer 1: ");
			alt_printf("%x ", curByte1val);
			if (curByte1val == 0x0)
				alt_putstr("\n");
			prev1 = strobeRead1val;
		}
		if(prev2 != strobeRead2val) {
			if (curByte2val == 0x0a)
				alt_printf("Downloading buffer 2: ");
			alt_printf("%x ", curByte2val);
			if (curByte2val == 0x0)
				alt_putstr("\n");
			prev2 = strobeRead2val;
		}

		if(readyToDownload1 | readyToDownload2) {
			IOWR_ALTERA_AVALON_PIO_DATA(outSignal, curOutSignal | 0x1);
		} else {
			IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x2);
		}
	}
}

