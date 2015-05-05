//-----------------------------------------------------------
// Module name:
// DE1_SoC
//
// Description:
// Top level module. Runs the interlock on the DE_SoC1. 
// Connects all helper modules with the switches, buttons,
// LEDs, and hex lights on the board.
// 
// Author(s):
// Cody Ohlsen
// Zach Nehrenberg
// Krista Holden
//
//----------------------------------------------------------- 
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	 input CLOCK_50;
	 output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	 output [9:0] LEDR; 
	 input [3:0] KEY; 
	 input [9:0] SW; 
	 
	 //user input wire assignments
	 wire downloadInput	=  SW[0];
	 wire reset 			= ~KEY[0];

	 // Camera wires
	 wire [6:0] displayCam1;
	 wire [6:0] displayCam1Seconds;
	 wire [3:0] percentCamera1;
	 wire [2:0] cam1OutSignals;
	 wire cam1Standby, cam1Film;

	 wire [6:0] displayCam2;
	 wire [6:0] displayCam2Seconds;
	 wire [3:0] percentCamera2;
	 wire [2:0] cam2OutSignals;
	 wire cam2Standby, cam2Film;
	 
	 // Default camera behavios
	 // 1 = start cam, 0 = not
	 parameter defaultCam1Behavior = 1'b1;
	 parameter defaultCam2Behavior = 1'b0;
	 

	 // HEX assignments
	 parameter blank = 7'b1111111;
	 assign HEX0 = displayCam2Seconds;
	 assign HEX1 = displayCam2;
	 assign HEX2 = blank;
	 assign HEX3 = blank;
	 assign HEX4 = displayCam1;
	 assign HEX5 = displayCam1Seconds;
	 
	 assign LEDR[9] = ~cam1Standby;
	 assign LEDR[8] = ~cam1Film;
	 
	 assign LEDR[4] = ~cam2Standby;
	 assign LEDR[3] = ~cam2Film;
	 
	 //User Input Wires
	 wire downloadInputUI;
	 wire resetUI;
	 
	 // Percentage control wires
	 wire countNegative1, countNegative2;
	 wire pauseCounter1, pauseCounter2;
	 
	 // Generate clk off of CLOCK_50, whichClock picks rate.
	 wire [31:0] clk;
	 
	 //uses clock 6 to use the lowest whole number of Hz for exactly precise timing.
	 parameter whichClock = 5;
	 
	 //clock 6 used in operation for the timer.
	 wire clock = clk[whichClock];
	 
	 ClockDivider cdiv (CLOCK_50, clk);	 
	 
	 // Percent Displays
	 CountUp countUpCam1 ( percentCamera1, displayCam1Seconds );
	 CountUp countUpCam2 ( percentCamera2, displayCam2Seconds );
	 
	 //sends all asynchronous input through a DFF
	 DFlipFlop downloadStuff ( downloadInputUI , downloadInput, clock, resetUI);
	 UserInput resetInput (clock, reset, resetUI );
	  
	 //instantiates the timer to get the percent loaded
	 Percents cam1Percent  (clock, resetUI, countNegative1, pauseCounter1, percentCamera1);
	 Percents cam2Percent  (clock, resetUI, countNegative2, pauseCounter2, percentCamera2);
	 
	 // initialize cameras
	 Camera camera1  (cam1Standby, cam1Film, pauseCounter1, countNegative1, displayCam1, cam1OutSignals, resetUI, clock, downloadInputUI, cam2OutSignals, defaultCam1Behavior, percentCamera1);
	 Camera camera2  (cam2Standby, cam2Film, pauseCounter2, countNegative2, displayCam2, cam2OutSignals, resetUI, clock, downloadInputUI, cam1OutSignals, defaultCam2Behavior, percentCamera2);
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
//module DE1_SoC_testbench ();
//	 reg        clock;
//	 wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
//	 wire [9:0] LEDR; 
//	 reg [3:0] KEY; 
//	 reg [9:0] SW; 
//	 
//	 reg rst;
//	 reg spacecraftArriving;
//	 reg spacecraftDeparting;
//	 reg outerPort	;
//	 reg innerPort ;
//	 reg pressurizeChamber;
//	 reg evacuateChamber;
//	 
//	 
//	assign KEY[0] = ~rst;
//	assign SW[0] = spacecraftArriving;
//	assign SW[1] = spacecraftDeparting;
//	assign SW[2] = outerPort;
//	assign SW[3] = innerPort;
//	assign KEY[1] = ~pressurizeChamber;
//	assign KEY[2] = ~evacuateChamber;
//	
//	reg helper;
//	parameter oneSec = 390625;
//	
//	parameter clkDur = 100;
//	
//	
//	// Set up the clock. 
//	initial clock=0;
//	initial helper = 0;
//	always begin 
//		#(clkDur/2); 
//		clock = ~clock; 
//	end
//	
//	always begin
//		#((clkDur * oneSec) / 2)
//		helper = ~helper;
//	end
//	initial rst = 0;
//	
//	DE1_SoC  dut (clock, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
//	
//	initial begin
//			pressurizeChamber = 0;
//			evacuateChamber = 0;
//			outerPort = 0;
//			innerPort = 0;
//			spacecraftArriving = 0;
//			spacecraftDeparting = 0;
//			
//			//arriving
//												@(posedge helper);
//			rst = 0;							@(posedge helper);
//												@(posedge helper);
//		 	rst = 1;							@(posedge helper);
//		 	rst = 0;							@(posedge helper);
//			rst = 0;							@(posedge helper);
//												@(posedge helper);
//		 	rst = 1;							@(posedge helper);
//		 	rst = 0;							@(posedge helper);
//												@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//			spacecraftArriving = 1;				@(posedge helper);
//												@(posedge helper);
//			spacecraftArriving = 0;				@(posedge helper);
//												@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			evacuateChamber = 1;      			@(posedge helper);
//			evacuateChamber = 0;      			@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												
//			// departing now
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//			spacecraftDeparting = 1;			@(posedge helper);
//												@(posedge helper);
//			spacecraftDeparting = 0;			@(posedge helper);
//												@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			evacuateChamber = 1;       			@(posedge helper);
//			evacuateChamber = 0;       			@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//		 	rst = 1;							@(posedge helper);
//		 	rst = 0;							@(posedge helper);
//												@(posedge helper);
//												
//			//testing invalid inputs before arrive/depart signal
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			rst = 1;							@(posedge helper);
//		 	rst = 0;							@(posedge helper);
//			
//			//testing invalid/valid inputs at all stages in arrive
//												@(posedge helper);
//			spacecraftArriving = 1;				@(posedge helper);
//												@(posedge helper);
//			spacecraftArriving = 0;				@(posedge helper);
//												@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			//testing wrong inputs
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			evacuateChamber = 1;       			@(posedge helper);
//			evacuateChamber = 0;       			@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			//testing wrong inputs
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			//testing wrong inputs
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//			rst = 1;							@(posedge helper);
//		 	rst = 0;							@(posedge helper);
//			
//			
//			
//			//testing invalid/valid inputs at all stages in depart
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//			//testing invalid inputs before arrive/depart signal
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//			spacecraftDeparting = 1;			@(posedge helper);
//												@(posedge helper);
//			spacecraftDeparting = 0;			@(posedge helper);
//												@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			//testing invalid inputs before arrive/depart signal
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			evacuateChamber = 1;       			@(posedge helper);
//			evacuateChamber = 0;       			@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			//testing invalid inputs before arrive/depart signal
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			//testing invalid inputs before arrive/depart signal
//			evacuateChamber = 1;				@(posedge helper);
//			evacuateChamber = 0;				@(posedge helper);
//			outerPort = 1;						@(posedge helper);
//			outerPort = 0;						@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//			pressurizeChamber = 1;				@(posedge helper);
//			pressurizeChamber = 0;				@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//												@(posedge helper);
//			innerPort = 1;						@(posedge helper);
//			innerPort = 0;						@(posedge helper);
//												@(posedge helper);
//		 	rst = 1;							@(posedge helper);
//		 	rst = 0;							@(posedge helper);
//												@(posedge helper);
//		
//		$stop; // End the simulation.
//	end
//endmodule
