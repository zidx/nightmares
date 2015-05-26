//-----------------------------------------------------------
// Module name:
// DE1_SoC
//
// Description:
// Implements a two-camrea system for a space station. When one camera is
// filming, it notifies the other camera when its buffer is 80% full to get
// ready for filming, then at 90% full, signals the other camera to start
// filming. When the other camera's buffer reaches 50% full, the first camera
// flushes its buffer if it has not recieved a signal to download by this time.
//
// Author(s):
// Cody Ohlsen
// Zach Nehrenberg
//
//----------------------------------------------------------- 
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	 input CLOCK_50;
	 output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	 output [9:0] LEDR; 
	 input [3:0] KEY; 
	 input [9:0] SW; 
	 
	 // User input wire assignments
	 wire reset 			= ~KEY[0];
	 
	 // Synchronized User Input Wires
	 wire resetUI;
	 
	 // Default camera behavios
	 // 	1 = start cam on reset, 0 = not
	 parameter defaultCam1Behavior = 1'b1;
	 parameter defaultCam2Behavior = 1'b0;
	 
	 // Idle state display of cameras show ready to download
	 parameter idleD = 7'b0111111;
	 
	 
	 // Percentage control wires
	 //	emptyBuffer:
	 //		Controls whether the buffer should be filling
	 //		or emptying. On high the buffer will count
	 //		backwards to zero.
	 //	pauseBuffer:
	 //		Specifies whether the buffer being filled should
	 //		pause filling itself or emptying itself.
	 wire emptyBuffer1, emptyBuffer2;
	 wire pauseBuffer1, pauseBuffer2;
	 

	 // HEX assignments
	 parameter blank = 7'b1111111;
	 assign HEX0 = displayCam2Percent;
	 assign HEX1 = displayCam2;
	 
	 assign HEX2 = blank;
	 assign HEX3 = blank;
	 
	 assign HEX4 = displayCam1;
	 assign HEX5 = displayCam1Percent;
	 
	 // LEDR assignments
	 assign LEDR[9] = ~cam1Standby;
	 assign LEDR[8] = ~cam1Film;
	 
	 assign LEDR[4] = ~cam2Standby;
	 assign LEDR[3] = ~cam2Film;
	 
	 
	 
	 // Generate clk off of CLOCK_50, whichClock picks rate.
	 // Rate determines buffer fill and empty rate
	 wire [31:0] clk;
	 
	 // Uses clock 6 for implementation to DE1-SoC
	 // Uses clock 0 for testing.
	 parameter whichClock = 6;
	 

	 // Clock 6 used in operation for the buffer, but for debugging
	 // clock 7 can be used to keep more time between states.
	 wire clock = clk[whichClock];
	 
	 ClockDivider cdiv (CLOCK_50, clk);	 
	 UserInput resetInput (clock, reset, resetUI );
	 
    switchesqsys u0 (
        .clk_clk                 (clk),                 //              clk.clk
        .reset_reset_n           (resetUI),           //            reset.reset_n
        .switches_export         (SW),         //         switches.export
        .leds_export             (LEDR),             //             leds.export
    );
	 
	 endmodule

module ClockDivider (clock, divided_clocks);
	 input clock;
	 output [31:0] divided_clocks;
	 reg [31:0] divided_clocks;

	 initial
	 divided_clocks = 0;

	 always @(posedge clock)
	 divided_clocks = divided_clocks + 1;
endmodule 

