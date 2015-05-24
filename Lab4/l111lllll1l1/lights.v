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
module lights (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDG, SW); 
	 input CLOCK_50;
	 output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	 output [7:0] LEDG; 
	 input [3:0] KEY; 
	 input [9:0] SW; 
	 
	 // User input wire assignments
	 wire reset 			= ~KEY[0];
	 
	 // Synchronized User Input Wires
	 wire resetUI;

	 // Camera wires:
	 //  Each camera has a series of variables associated with it.
	 //  All inputs are active high and all outputs are active low.
	 //	displayCam:
	 //		Output to the HEX display the current
	 //		state of the camera
	 //	displayCamPercent:
	 //		Output to the HEX display the current
	 //		percentage the camera's buffer is full.
	 //		Outputs only one value (i.e. 1 = 10 %)
	 //	percentCamera:
	 //		The percentage passed into the camera
	 //		of its buffer that has been filled, as
	 //		a number.
	 //	camOutSignals:
	 //		Signals such as 50%, standby, or start filming
	 //		Other cameras can take in these signals to know
	 //		when to start operations.
	 //	camStandby and camFilm:
	 //		Signals that the camera has recieved a go to 
	 //		standby request or a start filming request
	 wire [6:0] displayCam1;
	 wire [6:0] displayCam1Percent;
	 wire [3:0] percentCamera1;
	 wire [2:0] cam1OutSignals;
	 wire cam1Standby, cam1Film;

	 wire [6:0] displayCam2;
	 wire [6:0] displayCam2Percent;
	 wire [3:0] percentCamera2;
	 wire [2:0] cam2OutSignals;
	 wire cam2Standby, cam2Film;
	 
	 
	 wire[7:0] curByte1, curByte2;
	 
	 reg[7:0] nothing1, nothing2;
	 	 reg[2:0] microControllerOut;
	 
	 // Idle state display of cameras show ready to download
	 wire readyTodownload1 = (displayCam1 == idleD);
	 wire readyTodownload2 = (displayCam2 == idleD);
	 //assign LEDG[5] = readyTodownload;
	 
	 // Default camera behavios
	 // 	1 = start cam on reset, 0 = not
	 //parameter defaultCam1Behavior = 1'b1; microControllerOut[1]
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
	 
	 wire strobe1, strobe2;

	 // HEX assignments
	 parameter blank = 7'b1111111;
	 assign HEX0 = displayCam2Percent;
	 assign HEX1 = displayCam2;
	 
	 assign HEX2 = blank;
	 assign HEX3 = blank;
	 
	 assign HEX4 = displayCam1;
	 assign HEX5 = displayCam1Percent;
	 
	 // LEDG assignments
	 assign LEDG[7] = ~cam1Standby;
	 assign LEDG[6] = ~cam1Film;
	 
	 assign LEDG[4] = ~cam2Standby;
	 assign LEDG[3] = ~cam2Film;	 
	 
	 
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
	 
	 // Percent filled buffer displays
	 CountUp countUpCam1 ( percentCamera1, displayCam1Percent );
	 CountUp countUpCam2 ( percentCamera2, displayCam2Percent );
	 
	 // Sends all asynchronous input through a DFF
	 UserInput resetInput (clock, reset, resetUI );
	 
	 // Sets ResetState if reset is signaled
	 reg resetState;	 
	 initial resetState = 1;
	 
	 always @(posedge clock) begin
		if(resetUI) resetState = 1;
		else if(microControllerOut[1]) resetState = 0;
		else resetState = resetState;
	 end
	 
	  
	 // Instantiates buffer filler percent loaded feedback
	 Percents cam1Percent  (clock, resetState, emptyBuffer1, pauseBuffer1, percentCamera1);
	 Percents cam2Percent  (clock, resetState, emptyBuffer2, pauseBuffer2, percentCamera2);
	 	 
	 // Initialize cameras
	 Camera camera1  (cam1Standby, cam1Film, pauseBuffer1, emptyBuffer1, displayCam1, cam1OutSignals, resetState, clock, microControllerOut[0], cam2OutSignals, microControllerOut[1], percentCamera1);
	 Camera camera2  (cam2Standby, cam2Film, pauseBuffer2, emptyBuffer2, displayCam2, cam2OutSignals, resetState, clock, microControllerOut[0], cam1OutSignals, defaultCam2Behavior, percentCamera2);
	 
	 Buffer  buf1 (clock, resetState, emptyBuffer1, percentCamera1, percentCamera1, curByte1, strobe1 );
	 Buffer  buf2 (clock, resetState, emptyBuffer2, percentCamera2, percentCamera2, curByte2, strobe2 );
	 
	 
    switchesqsys u0 (
        .clk_clk                 (CLOCK_50),                 //              clk.clk
        .reset_reset_n           (KEY[0]),           //            reset.reset_n
        .switches_export         (nothing1),         //         switches.export
        .leds_export             (nothing2),             //             leds.export
        .readytodownload1_export (readyTodownload1), // readytodownload1.export
        .outsignal_export        (microControllerOut),        //        outsignal.export
        .curbyte1_export         (curByte1),         //         curbyte1.export
        .readytodownload2_export (readyTodownload2), // readytodownload2.export
        .curbyte2_export         (curByte2),          //         curbyte2.export
		  .stroberead1_export      (strobe1),      //      stroberead1.export
        .stroberead2_export      (strobe2)       //      stroberead2.export
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

//-----------------------------------------------------------
// Module name:
// DE1_SoC_testbench
//
// Description:
// Module implemented as part of testing system.
// Tests all possible states of DE1_SoC_testbench.
// 
// Author(s):
// Cody Ohlsen
//
//----------------------------------------------------------- 
