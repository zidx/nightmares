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

