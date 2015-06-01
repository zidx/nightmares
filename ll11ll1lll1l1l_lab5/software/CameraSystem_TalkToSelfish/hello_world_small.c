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

alt_u8 sendData(alt_u8 data);

int main() {
	IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x0);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0x0);

	IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x0);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0x0);

	alt_putstr("EARTH: Enter an F to start filming\n");
	char start = alt_getchar();
	///////////////////////////// SENDING MODE/RECIEVING MODE WITH SAME BOARD ////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//SEND MODE
	while (start != 'F') {
		alt_putstr("EARTH: Please enter an F to start filming.\n");
		start = alt_getchar();
	}
	// Start filming
	IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x2);
	alt_putstr("CAMERA: camera System Started.\n");
	while (1) {
		//repeatedly waits until ready to download
		IOWR_ALTERA_AVALON_PIO_DATA(load, 0x0);
		alt_u8 readyToDownload = IORD_ALTERA_AVALON_PIO_DATA(rtd);
		if (readyToDownload == 1) {
			alt_u8 downloadRequest = 255;
			alt_u8 giveDPermission = 254;
			alt_u8 strobe = 0;
			int downloadPermission = 1; // Request was sent back or not 0 for not
			alt_u8 curByte = 0;
			int count = 0;
			int wait_value = 10000;
			//CAMERA sends the d request
			alt_printf(
					"CAMERA: Camera ready to Download! Sending download ready signal to earth..\n");
			alt_u8 getRequest = sendData(downloadRequest);
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//RECIEVE MODE
			alt_printf("EARTH: Waiting for Ready to Download from camera... \n");

			if (getRequest == downloadRequest) {
				// Prompts user to give permission for the D
				char permission;
				//gets an empty character in case of reading in unwanted values unexpectedly
				alt_getchar();
				alt_putstr(
						"EARTH: Download Request recieved. Enter the D to give permission for the download. \n");
				permission = alt_getchar();
				//if user enter the D, send permission to downlad if ready to download
				readyToDownload = IORD_ALTERA_AVALON_PIO_DATA(rtd);
				if (permission == 'D' && readyToDownload == 1) {

					//sends the permission to the camera
					alt_printf("EARTH: Sending permission to the Camera...\n");
					alt_u8 recievedData = sendData(giveDPermission);

					//////////////////////////////////////////////////////////////////////////////////////////////////
					//SENDING MODE
					alt_printf("CAMERA: Waiting for download permission....");

					// Check if the recieved byte was for permission and no timeout
					if (downloadPermission) {
						curByte = recievedData;
						alt_printf("Permission Granted.\n", curByte);
					}
					// They did enter in D in this if loop, so this will always be true.
					if (curByte == giveDPermission) {
						alt_printf(
								"CAMERA: Downloading data to Earth\n");
						IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x3);

						//retrieve from the buffer camera
						int i;
						for (i = 0; i < 10; i++) {
							strobe = IORD_ALTERA_AVALON_PIO_DATA(inStrobe);
							while (strobe == 0) {
								strobe = IORD_ALTERA_AVALON_PIO_DATA(inStrobe);
							}
							curByte = IORD_ALTERA_AVALON_PIO_DATA(curByteIn);
							alt_printf("CAMERA: Sending Data from buffer: %x \n",
									curByte);

							alt_u8 recievedData = sendData(curByte);

							//////////////////////////////////////////////////////////////////////////////////////////////////
							//RECIEVING MODE

							alt_printf("EARTH: Recieving Data: %x\n", recievedData);

							//////////////////////////////////////////////////////////////////////////////////////////////////

						}
						alt_printf("CAMERA: Download Complete\n");
					} else {
						alt_printf(
								" DONT GO HERE!!!!!!!!!!!!!!!1LLLL1L1L1L1LL1L1L1Lll1l1l1l1l1l1ll1l1l1ll1l1 :) \n");
						return 0;
					}
					IOWR_ALTERA_AVALON_PIO_DATA(outSignal, 0x2);

					//////////////////////////////////////////////////////////////////////////////////////////////////

					alt_printf("EARTH: Download Complete.\n\n");
				} else if (!readyToDownload) {
					alt_printf(
							"EARTH: Permission Denied. Camera Timed Out and flushed.\n");
					//sends a zero to the camera
					alt_u8 zero = 0;
					alt_printf("EARTH: Sending Data: %x\n", zero);
					alt_u8 recievedData = sendData(zero);

					/////////////////////////////////////////////////////////////////
					curByte = recievedData;
					alt_printf("CAMERA: Recieving Data: %x. Permission Denied to Download.\n\n", curByte);

					//always true because just sent a zero
					if (curByte != giveDPermission) {
						// Wait for readyToDownload to turn off
						readyToDownload = IORD_ALTERA_AVALON_PIO_DATA(rtd);
						while (readyToDownload != 0) {
							readyToDownload = IORD_ALTERA_AVALON_PIO_DATA(rtd);
						}
					} else {
						alt_printf(
								"Unexpected system error. unreachable code.\n");
						return 0;
					}

					/////////////////////////////////////////////////////////////////

				} else { // Deny Permission for the D
					alt_printf("EARTH: sending Permission Denied signal.\n");
					//sends a zero to the camera
					alt_u8 zero = 0;

					alt_u8 recievedData = sendData(zero);

					/////////////////////////////////////////////////////////////////
					curByte = recievedData;
					alt_printf("CAMERA: Recieving Data: %x. Permission Denied to Download.\n\n", curByte);

					//always true because just sent a zero
					if (curByte != giveDPermission) {
						// Wait for readyToDownload to turn off
						readyToDownload = IORD_ALTERA_AVALON_PIO_DATA(rtd);
						while (readyToDownload != 0) {
							readyToDownload = IORD_ALTERA_AVALON_PIO_DATA(rtd);
						}
					} else {
						alt_printf(
								"Unexpected system error. unreachable code.\n");
						return 0;
					}

					/////////////////////////////////////////////////////////////////

				}
			} else { //strobed, but no request
				alt_printf("incorrect download request recieved. \n");
			}
		}
	}
	return 0;
}

//the hemptea signal occurs at the same time as our strobe.
// Therefore, acting as both the camera controller and the
// Earth substation will only work if we use the hemptea signal
// as the iniput strobe for incoming serial data. we return
// the byte sent by reading the input byte (because the input and
// output are connected together in this case). This shows that
// the output data is correctly recieved into the input buffer
// but there is no time to get the strobe after send
alt_u8 sendData(alt_u8 data) {
	alt_u8 empty = 0;
//sends data to camera
	IOWR_ALTERA_AVALON_PIO_DATA(curByteOut, data);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0x1);
	//alt_printf("Sending data: %d\n", data);
	empty = IORD_ALTERA_AVALON_PIO_DATA(hempTea);
	while (empty == 0) {
		empty = IORD_ALTERA_AVALON_PIO_DATA(hempTea);
	}
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0x0);

	return IORD_ALTERA_AVALON_PIO_DATA(curByteIn);
}
