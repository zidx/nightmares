/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_processor' in SOPC Builder design 'switchesqsys'
 * SOPC Builder design path: ../../switchesqsys.sopcinfo
 *
 * Generated: Thu May 21 17:14:41 PDT 2015
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00002820
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0xe
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00001020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0xe
#define ALT_CPU_NAME "nios2_processor"
#define ALT_CPU_RESET_ADDR 0x00001000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00002820
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0xe
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00001020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0xe
#define NIOS2_RESET_ADDR 0x00001000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_NIOS2_QSYS


/*
 * LEDs configuration
 *
 */

#define ALT_MODULE_CLASS_LEDs altera_avalon_pio
#define LEDS_BASE 0x3080
#define LEDS_BIT_CLEARING_EDGE_REGISTER 0
#define LEDS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LEDS_CAPTURE 0
#define LEDS_DATA_WIDTH 8
#define LEDS_DO_TEST_BENCH_WIRING 0
#define LEDS_DRIVEN_SIM_VALUE 0
#define LEDS_EDGE_TYPE "NONE"
#define LEDS_FREQ 50000000
#define LEDS_HAS_IN 0
#define LEDS_HAS_OUT 1
#define LEDS_HAS_TRI 0
#define LEDS_IRQ -1
#define LEDS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LEDS_IRQ_TYPE "NONE"
#define LEDS_NAME "/dev/LEDs"
#define LEDS_RESET_VALUE 0
#define LEDS_SPAN 16
#define LEDS_TYPE "altera_avalon_pio"


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x3090
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x3090
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x3090
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "switchesqsys"


/*
 * curByte1 configuration
 *
 */

#define ALT_MODULE_CLASS_curByte1 altera_avalon_pio
#define CURBYTE1_BASE 0x3040
#define CURBYTE1_BIT_CLEARING_EDGE_REGISTER 0
#define CURBYTE1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CURBYTE1_CAPTURE 0
#define CURBYTE1_DATA_WIDTH 8
#define CURBYTE1_DO_TEST_BENCH_WIRING 0
#define CURBYTE1_DRIVEN_SIM_VALUE 0
#define CURBYTE1_EDGE_TYPE "NONE"
#define CURBYTE1_FREQ 50000000
#define CURBYTE1_HAS_IN 1
#define CURBYTE1_HAS_OUT 0
#define CURBYTE1_HAS_TRI 0
#define CURBYTE1_IRQ -1
#define CURBYTE1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CURBYTE1_IRQ_TYPE "NONE"
#define CURBYTE1_NAME "/dev/curByte1"
#define CURBYTE1_RESET_VALUE 0
#define CURBYTE1_SPAN 16
#define CURBYTE1_TYPE "altera_avalon_pio"


/*
 * curByte2 configuration
 *
 */

#define ALT_MODULE_CLASS_curByte2 altera_avalon_pio
#define CURBYTE2_BASE 0x3020
#define CURBYTE2_BIT_CLEARING_EDGE_REGISTER 0
#define CURBYTE2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CURBYTE2_CAPTURE 0
#define CURBYTE2_DATA_WIDTH 8
#define CURBYTE2_DO_TEST_BENCH_WIRING 0
#define CURBYTE2_DRIVEN_SIM_VALUE 0
#define CURBYTE2_EDGE_TYPE "NONE"
#define CURBYTE2_FREQ 50000000
#define CURBYTE2_HAS_IN 1
#define CURBYTE2_HAS_OUT 0
#define CURBYTE2_HAS_TRI 0
#define CURBYTE2_IRQ -1
#define CURBYTE2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CURBYTE2_IRQ_TYPE "NONE"
#define CURBYTE2_NAME "/dev/curByte2"
#define CURBYTE2_RESET_VALUE 0
#define CURBYTE2_SPAN 16
#define CURBYTE2_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x3090
#define JTAG_UART_IRQ 5
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * onchip_memory configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory altera_avalon_onchip_memory2
#define ONCHIP_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY_BASE 0x1000
#define ONCHIP_MEMORY_CONTENTS_INFO ""
#define ONCHIP_MEMORY_DUAL_PORT 0
#define ONCHIP_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY_INIT_CONTENTS_FILE "switchesqsys_onchip_memory"
#define ONCHIP_MEMORY_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY_IRQ -1
#define ONCHIP_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY_NAME "/dev/onchip_memory"
#define ONCHIP_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY_SIZE_VALUE 4096
#define ONCHIP_MEMORY_SPAN 4096
#define ONCHIP_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY_WRITABLE 1


/*
 * outSignal configuration
 *
 */

#define ALT_MODULE_CLASS_outSignal altera_avalon_pio
#define OUTSIGNAL_BASE 0x3050
#define OUTSIGNAL_BIT_CLEARING_EDGE_REGISTER 0
#define OUTSIGNAL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OUTSIGNAL_CAPTURE 0
#define OUTSIGNAL_DATA_WIDTH 2
#define OUTSIGNAL_DO_TEST_BENCH_WIRING 0
#define OUTSIGNAL_DRIVEN_SIM_VALUE 0
#define OUTSIGNAL_EDGE_TYPE "NONE"
#define OUTSIGNAL_FREQ 50000000
#define OUTSIGNAL_HAS_IN 0
#define OUTSIGNAL_HAS_OUT 1
#define OUTSIGNAL_HAS_TRI 0
#define OUTSIGNAL_IRQ -1
#define OUTSIGNAL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OUTSIGNAL_IRQ_TYPE "NONE"
#define OUTSIGNAL_NAME "/dev/outSignal"
#define OUTSIGNAL_RESET_VALUE 0
#define OUTSIGNAL_SPAN 16
#define OUTSIGNAL_TYPE "altera_avalon_pio"


/*
 * readyToDownload1 configuration
 *
 */

#define ALT_MODULE_CLASS_readyToDownload1 altera_avalon_pio
#define READYTODOWNLOAD1_BASE 0x3060
#define READYTODOWNLOAD1_BIT_CLEARING_EDGE_REGISTER 0
#define READYTODOWNLOAD1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define READYTODOWNLOAD1_CAPTURE 0
#define READYTODOWNLOAD1_DATA_WIDTH 1
#define READYTODOWNLOAD1_DO_TEST_BENCH_WIRING 0
#define READYTODOWNLOAD1_DRIVEN_SIM_VALUE 0
#define READYTODOWNLOAD1_EDGE_TYPE "NONE"
#define READYTODOWNLOAD1_FREQ 50000000
#define READYTODOWNLOAD1_HAS_IN 1
#define READYTODOWNLOAD1_HAS_OUT 0
#define READYTODOWNLOAD1_HAS_TRI 0
#define READYTODOWNLOAD1_IRQ -1
#define READYTODOWNLOAD1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define READYTODOWNLOAD1_IRQ_TYPE "NONE"
#define READYTODOWNLOAD1_NAME "/dev/readyToDownload1"
#define READYTODOWNLOAD1_RESET_VALUE 0
#define READYTODOWNLOAD1_SPAN 16
#define READYTODOWNLOAD1_TYPE "altera_avalon_pio"


/*
 * readyToDownload2 configuration
 *
 */

#define ALT_MODULE_CLASS_readyToDownload2 altera_avalon_pio
#define READYTODOWNLOAD2_BASE 0x3030
#define READYTODOWNLOAD2_BIT_CLEARING_EDGE_REGISTER 0
#define READYTODOWNLOAD2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define READYTODOWNLOAD2_CAPTURE 0
#define READYTODOWNLOAD2_DATA_WIDTH 1
#define READYTODOWNLOAD2_DO_TEST_BENCH_WIRING 0
#define READYTODOWNLOAD2_DRIVEN_SIM_VALUE 0
#define READYTODOWNLOAD2_EDGE_TYPE "NONE"
#define READYTODOWNLOAD2_FREQ 50000000
#define READYTODOWNLOAD2_HAS_IN 1
#define READYTODOWNLOAD2_HAS_OUT 0
#define READYTODOWNLOAD2_HAS_TRI 0
#define READYTODOWNLOAD2_IRQ -1
#define READYTODOWNLOAD2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define READYTODOWNLOAD2_IRQ_TYPE "NONE"
#define READYTODOWNLOAD2_NAME "/dev/readyToDownload2"
#define READYTODOWNLOAD2_RESET_VALUE 0
#define READYTODOWNLOAD2_SPAN 16
#define READYTODOWNLOAD2_TYPE "altera_avalon_pio"


/*
 * strobeRead1 configuration
 *
 */

#define ALT_MODULE_CLASS_strobeRead1 altera_avalon_pio
#define STROBEREAD1_BASE 0x3010
#define STROBEREAD1_BIT_CLEARING_EDGE_REGISTER 0
#define STROBEREAD1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define STROBEREAD1_CAPTURE 0
#define STROBEREAD1_DATA_WIDTH 1
#define STROBEREAD1_DO_TEST_BENCH_WIRING 0
#define STROBEREAD1_DRIVEN_SIM_VALUE 0
#define STROBEREAD1_EDGE_TYPE "NONE"
#define STROBEREAD1_FREQ 50000000
#define STROBEREAD1_HAS_IN 1
#define STROBEREAD1_HAS_OUT 0
#define STROBEREAD1_HAS_TRI 0
#define STROBEREAD1_IRQ -1
#define STROBEREAD1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define STROBEREAD1_IRQ_TYPE "NONE"
#define STROBEREAD1_NAME "/dev/strobeRead1"
#define STROBEREAD1_RESET_VALUE 0
#define STROBEREAD1_SPAN 16
#define STROBEREAD1_TYPE "altera_avalon_pio"


/*
 * strobeRead2 configuration
 *
 */

#define ALT_MODULE_CLASS_strobeRead2 altera_avalon_pio
#define STROBEREAD2_BASE 0x3000
#define STROBEREAD2_BIT_CLEARING_EDGE_REGISTER 0
#define STROBEREAD2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define STROBEREAD2_CAPTURE 0
#define STROBEREAD2_DATA_WIDTH 1
#define STROBEREAD2_DO_TEST_BENCH_WIRING 0
#define STROBEREAD2_DRIVEN_SIM_VALUE 0
#define STROBEREAD2_EDGE_TYPE "NONE"
#define STROBEREAD2_FREQ 50000000
#define STROBEREAD2_HAS_IN 1
#define STROBEREAD2_HAS_OUT 0
#define STROBEREAD2_HAS_TRI 0
#define STROBEREAD2_IRQ -1
#define STROBEREAD2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define STROBEREAD2_IRQ_TYPE "NONE"
#define STROBEREAD2_NAME "/dev/strobeRead2"
#define STROBEREAD2_RESET_VALUE 0
#define STROBEREAD2_SPAN 16
#define STROBEREAD2_TYPE "altera_avalon_pio"


/*
 * switches configuration
 *
 */

#define ALT_MODULE_CLASS_switches altera_avalon_pio
#define SWITCHES_BASE 0x3070
#define SWITCHES_BIT_CLEARING_EDGE_REGISTER 0
#define SWITCHES_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SWITCHES_CAPTURE 0
#define SWITCHES_DATA_WIDTH 8
#define SWITCHES_DO_TEST_BENCH_WIRING 0
#define SWITCHES_DRIVEN_SIM_VALUE 0
#define SWITCHES_EDGE_TYPE "NONE"
#define SWITCHES_FREQ 50000000
#define SWITCHES_HAS_IN 1
#define SWITCHES_HAS_OUT 0
#define SWITCHES_HAS_TRI 0
#define SWITCHES_IRQ -1
#define SWITCHES_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SWITCHES_IRQ_TYPE "NONE"
#define SWITCHES_NAME "/dev/switches"
#define SWITCHES_RESET_VALUE 0
#define SWITCHES_SPAN 16
#define SWITCHES_TYPE "altera_avalon_pio"

#endif /* __SYSTEM_H_ */
