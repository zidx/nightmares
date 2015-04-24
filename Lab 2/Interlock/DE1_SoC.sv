// Top Level module
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	 input CLOCK_50;
	 output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	 output [9:0] LEDR; 
	 input [3:0] KEY; 
	 input [9:0] SW; 
	 
	 reg [2:0] pCounter;
	 reg [2:0] nCounter;
	 
	 reg rstCounterEntering;
	 reg rstCounterExiting;
	 
	 reg shipDocked;
	 
	 //user input wire assignments
	 wire spacecraftArriving   =  SW[0];
	 wire spacecraftDeparting  =  SW[1];
	 wire outerPort				=  SW[2];
	 wire innerPort 				=  SW[3];
	 wire reset 					= ~KEY[0];
	 wire pressurizeChamber    = ~KEY[1];
	 wire evacuateChamber 		= ~KEY[2];
	 wire [6:0] displayArrive;
	 wire [6:0] displayDepart;
	 wire [6:0] displaySeconds;
	 wire enteringCanOut, enteringCanIn, leavingCanOut, leavingCanIn;
	 
	 parameter blank = 7'b1111111;
	 assign HEX0 = displayArrive;
	 assign HEX1 = displayDepart;
	 assign HEX2 = blank;
	 assign HEX3 = blank;
	 assign HEX4 = blank;
	 assign HEX5 = displaySeconds;
	 
	 //User Input Wires
	 wire spacecraftArrivingUI;
	 wire spacecraftDepartingUI;
	 wire outerPortUI;
	 wire innerPortUI;
	 wire resetUI;
	 wire pressurizeChamberUI;
	 wire evacuateChamberUI;
	 
	 wire rstEnteringDFF;
	 wire rstExitingDFF;
	 
	 // Generate clk off of CLOCK_50, whichClock picks rate.
	 wire [31:0] clk;
	 
	 //clock cycles for timer output to time number of seconds
	 parameter fiveSec  = 4'b0101;
	 parameter sevenSec = 4'b0111;
	 parameter eightSec = 4'b1000;
	 
	 //uses clock 6 to use the lowest whole number of Hz for exactly precise timing.
	 parameter whichClock = 6;
	 
	 //clock 6 used in operation for the timer.
	 wire clock = clk[whichClock];
	 wire [3:0] numSeconds;
	 
	 wire [2:0] counterVal;
	 assign counterVal = {numSeconds == eightSec, numSeconds == sevenSec, numSeconds == fiveSec};	 
	 
	 
	 // LEDR[0] says spacecraft is arriving
	 // LEDR[1] indicates spacecraft is departing
	 assign LEDR[0] = spacecraftArrivingUI;
	 assign LEDR[1] = spacecraftDepartingUI;
	 
	 // LEDR[2] is On if the outer port is open
	 // LEDR[3] is on if the inner port is open
	 assign LEDR[2] = outerPortUI & (enteringCanOut | leavingCanOut);
	 assign LEDR[3] = innerPortUI & (enteringCanIn  & leavingCanIn );
	 
	 // LEDR[4] corresponds to pressurized
	 // LEDR[5] corresponds to depressurzed
	 assign LEDR[4] = enteringCanIn | leavingCanIn;
	 assign LEDR[5] = enteringCanOut | leavingCanOut;
	 
	 // LEDR[8] corresponds to if a ship is docked
	 assign LEDR[8] = shipDocked;
	 
	 // Keep track if a ship is docked
	 initial shipDocked = 0;
	 always @(*) begin
		if(rst) begin
			shipDocked = 0;
		end
		else begin
			if(spacecraftArrivingUI) shipDocked = 1;
			else if(spacecraftDepartingUI) shipDocked = 0;			
		end
	 end
	 
	 ClockDivider cdiv (CLOCK_50, clk);	 
	 CountUp countUpinst ( numSeconds, displaySeconds );
	 
	 //sends all asynchronous input through a DFF
	 DFlipFlop arriving (spacecraftArrivingUI , spacecraftArriving, clock, resetUI);
	 DFlipFlop departing (spacecraftDepartingUI, spacecraftDeparting, clock, resetUI );
	 DFlipFlop outPort (outerPortUI, outerPort, clock, resetUI );
	 DFlipFlop inPort (innerPortUI, innerPort, clock, resetUI );
	 
	 DFlipFlop dffdelay (rstEnteringDFF, rstCounterEntering, clock, resetUI );
	 DFlipFlop dffdelay2 (rstExitingDFF, rstCounterExiting, clock, resetUI );
	 
	 UserInput resetInput (clock, reset, resetUI );
	 UserInput pressurizeInput (clock, pressurizeChamber, pressurizeChamberUI );
	 UserInput evacuateInput (clock, evacuateChamber, evacuateChamberUI );
	  
	 //instantiates the timer to get the number of seconds
	 Timer secTimer  (clock, reset | rstEnteringDFF | rstExitingDFF, numSeconds);	 
	 
	 //instantiate both State Machines
	 enteringUranus enteringInterlock (resetUI, rstCounterEntering, clock, innerPortUI, outerPortUI, spacecraftArrivingUI, evacuateChamberUI, pressurizeChamberUI, counterVal, displayArrive, enteringCanOut, enteringCanIn);
	 leavingUranus  leavingInterlock  (resetUI, rstCounterExiting, clock, innerPortUI, outerPortUI, spacecraftDepartingUI, evacuateChamberUI, pressurizeChamberUI, counterVal, displayDepart, leavingCanOut,  leavingCanIn );
	 
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
// Krista Holden
//
//----------------------------------------------------------- 
module DE1_SoC_testbench ();
	 reg        clock;
	 wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	 wire [9:0] LEDR; 
	 reg [3:0] KEY; 
	 reg [9:0] SW; 
	 reg rst = ~KEY[0];
	
	reg helper;
	parameter oneSec = 390625;
	
	parameter clkDur = 100;
	
	
	// Set up the clock. 
	initial clock=0;
	initial helper = 0;
	always begin 
		#(clkDur/2); 
		clock = ~clock; 
	end
	
	always begin
		#((clkDur * oneSec) / 2)
		helper = ~helper;
	end
	initial rst = 0;
	
	DE1_SoC  dut (clock, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
	
	initial begin
			rst = 0;		@(posedge helper);
		 	rst = 1;		@(posedge helper);
		 	rst = 0;		@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
							@(posedge helper);
		 	rst = 1;		@(posedge helper);
		 	rst = 0;		@(posedge helper);
		
		
		$stop; // End the simulation.
	end
endmodule